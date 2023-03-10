require "radio/SWWS_SystemFaults"
require "radio/SWWS_Schedules"
require "radio/SWWS_Strings"
require "SWWS_Debug"
require "SWWS_Data"

SWWS_Core = {}


function SWWS_Core.LoadGameplayOptions()
	-------------------------------------------------------
	-- GAMEPLAY OPTIONS --
	-- Do NOT edit; this is handled through SandboxVars now!
	-------------------------------------------------------

	SWWS_Core.config = SWWS_Core.config or {}

	------------------------------------------------------
	-- Does the Knox Power Grid need to be off before faults start occuring?
	-- If enabled, will prevent any interruptions/faults until the Power Grid fails.

	SWWS_Core.config.requireShutoff = SandboxVars.SaveOurStationCore.RequirePowerShutoff

	-------------------------------------------------------
	-- Are Interruptions (Non-Fatal Faults) enabled?
	-- Interruptions are types of faults that resolve themselves.

	SWWS_Core.config.enableInterruptions = SandboxVars.SaveOurStationCore.EnableInterruptions

	-------------------------------------------------------
	-- Are Faults (Fatal Failures) enabled?
	-- Faults require player intervention to be resolved. Further finrotmation

	SWWS_Core.config.enableFaults = SandboxVars.SaveOurStationCore.EnableFaults

	-------------------------------------------------------
	-- These values represent the percentage chance for each pool to occur, and should add up to 100:
	-- Interruption | The EBS has an Interruption/Outage that resolves itself after some time, without player intervention.
	-- Fault | EBS has a fatal fault that requires the player to intervene and fix it.

	if SandboxVars.SaveOurStationCore.ReliabilityProfile == 1 then
		SWWS_Core.config.reliabilityDescription = "Well-Maintained"
		SWWS_Core.config.reliabilityChancePool = {
			Nominal      = { probability = 80 },
			Interruption = { probability = 15 },
			Fault        = { probability = 5 },
		}
	elseif SandboxVars.SaveOurStationCore.ReliabilityProfile == 2 then
		SWWS_Core.config.reliabilityDescription = "Reliable"
		SWWS_Core.config.reliabilityChancePool = {
			Nominal      = { probability = 70 },
			Interruption = { probability = 25 },
			Fault        = { probability = 5 },
		}
	elseif SandboxVars.SaveOurStationCore.ReliabilityProfile == 3 or SandboxVars.SaveOurStationCore.ReliabilityProfile == nil then
		SWWS_Core.config.reliabilityDescription = "Default"
		SWWS_Core.config.reliabilityChancePool = {
			Nominal      = { probability = 55 },
			Interruption = { probability = 35 },
			Fault        = { probability = 10 },
		}
	elseif SandboxVars.SaveOurStationCore.ReliabilityProfile == 4 then
		SWWS_Core.config.reliabilityDescription = "Unreliable"
		SWWS_Core.config.reliabilityChancePool = {
			Nominal      = { probability = 45 },
			Interruption = { probability = 35 },
			Fault        = { probability = 20 },
		}
	elseif SandboxVars.SaveOurStationCore.ReliabilityProfile == 5 then
		SWWS_Core.config.reliabilityDescription = "Lost Cause"
		SWWS_Core.config.reliabilityChancePool = {
			Nominal      = { probability = 35 },
			Interruption = { probability = 35 },
			Fault        = { probability = 30 },
		}
	end

	-------------------------------------------------------
	-- Fault/Interruption/Downtime stages have a minimum/maximum duration, defined in hours within SWWS_Schedules.lua.
	-- This controls the factor by which said hours are multiplied, e.g. to give players more time to fix a fault,
	-- or to increase the time between failures occuring.

	if SandboxVars.SaveOurStationCore.TimeDurationMultiplier == 1 then
		SWWS_Core.config.timeDurationMultiplier = 12
	elseif SandboxVars.SaveOurStationCore.TimeDurationMultiplier == 2 then
		SWWS_Core.config.timeDurationMultiplier = 18
	elseif SandboxVars.SaveOurStationCore.TimeDurationMultiplier == 3 or SandboxVars.SaveOurStationCore.TimeDurationMultiplier == nil then
		SWWS_Core.config.timeDurationMultiplier = 24
	elseif SandboxVars.SaveOurStationCore.TimeDurationMultiplier == 4 then
		SWWS_Core.config.timeDurationMultiplier = 32
	end

	if SWWS_Debug.logging then
		print("SWWS: ")
		print("SWWS: --- [ Config ] ---")
		print("SWWS: > Require Power Shutoff? ", SWWS_Core.config.requireShutoff)
		print("SWWS: > Interruptions enabled? ", SWWS_Core.config.enableInterruptions)
		print("SWWS: > AEBS Faults enabled? ", SWWS_Core.config.enableFaults)
		print("SWWS: > Time Duration Multiplier: ", SWWS_Core.config.timeDurationMultiplier)
		print("SWWS: > Reliability Profile: ", SWWS_Core.config.reliabilityDescription)
		SWWS_Debug.PrintTable(SWWS_Core.config.reliabilityChancePool)
		print("SWWS: ----------------------------")
	end

end

function SWWS_Core.GameBoot()
	-- Server does not seem to load translation files by default...
	Translator.loadFiles()
end

Events.OnGameBoot.Add(SWWS_Core.GameBoot)

function SWWS_Core.Initialize()

	if SWWS_Core.isInitialized then
		return
	end

	SWWS_Data.Load()

	if SWWS_Debug.forceInitialize or not SWWS_Data.saveData then
		SWWS_Debug.forceInitialize = false

		if SWWS_Debug.logging then
			print("SWWS: saveData nil, initializing")
		end

		SWWS_Data.saveData = {}
		SWWS_Core.ScheduleFailure()
	end

	SWWS_Core.isInitialized = true

	SWWS_Data.Save()
end

function SWWS_Core.OnEveryHour()
	SWWS_Core.LoadGameplayOptions()
	SWWS_Core.Initialize()
	SWWS_Core.UpdateFailure()

	SWWS_Data.Save()
end

Events.EveryHours.Add(SWWS_Core.OnEveryHour)


-- This function takes the Probability Tables that are set in "shared/SWWS_Core.lua" and evaluates them based on the cumulative probability.
-- Credit goes to to user "Mud" on StackOverflow for this great solution.
-- Source, per 02/2023: https://stackoverflow.com/questions/23437573/how-to-setup-the-correct-logic-for-picking-a-random-item-from-a-list-based-on-it
function SWWS_Core.GetPoolChance()
	local probability = ZombRand(100) + 1
	local cumulativeProbability = 0

	for name, entry in pairs(SWWS_Core.config.reliabilityChancePool) do
		cumulativeProbability = cumulativeProbability + entry.probability
		if probability <= cumulativeProbability then
			return name
		end
	end
end


function SWWS_Core.ScheduleFailure()

	if not SWWS_Locations then
		print("SWWS: Error, no locations have been defined!")
		return
	elseif SWWS_Debug.logging then
		print("SWWS: Locations contains " .. #SWWS_Locations .. " entries")
	end

	local selectedPoolName = SWWS_Core.GetPoolChance()
	local selectedPoolType = SWWS_Schedules.poolTypes.nominal

	if selectedPoolName == "Interruption" then
		if SWWS_Core.config.enableInterruptions then
			selectedPoolType = SWWS_Schedules.poolTypes.nonFatal

		else
			selectedPoolType = SWWS_Schedules.poolTypes.nominal
			selectedPoolName = "Interruption (Overridden)"
			print("SWWS: Interruptions not enabled - choosing Nominal pool instead.")
		end

	elseif selectedPoolName == "Fault" then
		if SWWS_Core.config.enableFaults then
			selectedPoolType = SWWS_Schedules.poolTypes.fatal

		else
			selectedPoolType = SWWS_Schedules.poolTypes.nominal
			selectedPoolName = "Fault (Overridden)"
			print("SWWS: Faults not enabled - choosing Nominal pool instead.")
		end

	elseif selectedPoolName == "Nominal" then
		selectedPoolType = SWWS_Schedules.poolTypes.nominal

	else
		-- This should never happen.
		print("SWWS: Error, unrecognized pool name: "..selectedPoolName)

	end


	if SWWS_Debug.forceFatal then
		if SWWS_Debug.logging then
			selectedPoolType = SWWS_Schedules.poolTypes.fatal
			print("SWWS: Pool force-selected: ", selectedPoolName)
		end

	elseif SWWS_Debug.forceNonFatal then
		if SWWS_Debug.logging then
			selectedPoolType = SWWS_Schedules.poolTypes.nonFatal
			print("SWWS: Pool force-selected: ", selectedPoolName)
		end
	end


	if SWWS_Debug.logging then
		print("SWWS: Pool Result: ", selectedPoolName, " -> Schedule Type: ", selectedPoolType)
	end

	local poolIndices = {}

	for i,v in ipairs(SWWS_Schedules.pool) do
		if v.poolType == selectedPoolType then
			table.insert(poolIndices, i)
		end
	end

	local schedule = SWWS_Schedules.pool[poolIndices[ZombRand(1, #poolIndices + 1)]]
	local location = SWWS_Locations[ZombRand(1, #SWWS_Locations + 1)]

	SWWS_Data.saveData.locationId = location.id
	SWWS_Data.saveData.locationRoomName = location.roomName

	SWWS_Data.saveData.scheduleId = schedule.id
	SWWS_Data.saveData.stageIndex = 1

	local stage = schedule.stages[1]

	SWWS_Core.GenerateStageRemaining(stage)

	SWWS_Data.saveData.conditionLower = getRadioText(SWWS_Strings.conditions[ZombRand(1, #SWWS_Strings.conditions + 1)])
	SWWS_Data.saveData.conditionUpper = SWWS_Data.saveData.conditionLower:gsub("^%l", string.upper)

	local system = SWWS_SystemFaults.pool[ZombRand(1, #SWWS_SystemFaults.pool + 1)]
	SWWS_Data.saveData.systemId = getRadioText(system.id)
	SWWS_Data.saveData.systemRepair = system.repairs[ZombRand(1, #system.repairs + 1)]
	SWWS_Data.saveData.systemRepairComplete = false;

	local serialFormat = ZombRand(1, 5)
	local serial = SWWS_Strings.serials[ZombRand(1, #SWWS_Strings.serials + 1)]

	if serialFormat == 1 then
		-- AA
		serial = serial .. SWWS_Strings.serials[ZombRand(1, #SWWS_Strings.serials + 1)]
	elseif serialFormat == 2 then
		-- AN
		serial = serial .. ZombRand(0, 10)
	elseif serialFormat == 3 then
		-- AANN
		serial = serial .. SWWS_Strings.serials[ZombRand(1, #SWWS_Strings.serials + 1)]
		serial = serial .. ZombRand(0, 10)
		serial = serial .. ZombRand(0, 10)
	else
		-- ANNN
		serial = serial .. ZombRand(0, 10)
		serial = serial .. ZombRand(0, 10)
		serial = serial .. ZombRand(0, 10)
	end

	SWWS_Data.saveData.systemName = SWWS_Data.saveData.systemId .. "_" .. serial

	-- gsub returns a table, so we do this to avoid random numbers getting added to our table.
	local repairInstructionLocation = getRadioText("AEBS_LocationRequiresUtilCrewDispatch"):gsub("{location}", location.id)
	local repairInstructionCode = getRadioText("AEBS_DiagnosticCode"):gsub("{code}", SWWS_Data.saveData.systemRepair.solution.code):gsub("{system}", SWWS_Data.saveData.systemName):gsub("{description}", getRadioText(SWWS_Data.saveData.systemRepair.description))

	SWWS_Data.saveData.systemRepairInstructions = {
		repairInstructionLocation,
		repairInstructionCode
	}

	SWWS_Data.Save()

end

function SWWS_Core.UpdateFailure()

	if not SWWS_Locations then
		print("SWWS: Error, no locations have been defined!")
		return
	end

	if SWWS_Debug.ignoreRequirePowerShutoff then
		if SWWS_Debug.logging then
			print("SWWS: Ignoring requirements for power grid shutoff")
		end
	else
		if SWWS_Core.config.requireShutoff then
			if getGameTime():getNightsSurvived() < getSandboxOptions():getElecShutModifier() then
				if SWWS_Debug.logging then
					print("SWWS: Power grid not off - skipping failure update")
				end
				return
			end
		end
	end

	if SWWS_Data.saveData.systemRepairComplete then
		SWWS_Core.ScheduleFailure()
		return
	end

	local schedule = SWWS_Core.GetCurrentSchedule()
	local stage = schedule.stages[SWWS_Data.saveData.stageIndex]

	if 0 < SWWS_Data.saveData.stageRemaining then
		SWWS_Data.saveData.stageRemaining = SWWS_Data.saveData.stageRemaining - 1

		if SWWS_Data.saveData.stageRemaining == 0 then
			if SWWS_Data.saveData.stageIndex < #schedule.stages then
				SWWS_Data.saveData.stageIndex = SWWS_Data.saveData.stageIndex + 1
				stage = schedule.stages[SWWS_Data.saveData.stageIndex]
				SWWS_Core.GenerateStageRemaining(stage)
				if SWWS_Debug.logging then
					print("SWWS: Progressed to stage #" .. SWWS_Data.saveData.stageIndex .. " of " .. SWWS_Data.saveData.scheduleId)
					print("SWWS: Location " .. SWWS_Data.saveData.locationId .. " | Schedule " .. SWWS_Data.saveData.scheduleId .. ", Stage " .. SWWS_Data.saveData.stageIndex)
					print("SWWS: System " .. SWWS_Data.saveData.systemName .. " | Repair " .. SWWS_Data.saveData.systemRepair.description)
				end
			elseif schedule.poolType ~= SWWS_Schedules.poolTypes.fatal then
				-- This was not a fatal fault, schedule the next failure...
				SWWS_Core.ScheduleFailure()
			end
		elseif SWWS_Debug.logging then
			print("SWWS: Stage remaining " .. SWWS_Data.saveData.stageRemaining .. " hours")
			print("SWWS: Location " .. SWWS_Data.saveData.locationId .. " | Schedule " .. SWWS_Data.saveData.scheduleId .. ", Stage " .. SWWS_Data.saveData.stageIndex)
			print("SWWS: System " .. SWWS_Data.saveData.systemName .. " | Repair " .. SWWS_Data.saveData.systemRepair.description)
		end
	end
end

function SWWS_Core.GenerateStageRemaining(_stage)
	if SWWS_Debug.forceMinimumTime then
		SWWS_Data.saveData.stageRemaining = 1

		if SWWS_Debug.logging then
			print("SWWS: Forced stageRemaining to " .. SWWS_Data.saveData.stageRemaining)
		end
	else
		SWWS_Data.saveData.stageRemaining = SWWS_Core.config.timeDurationMultiplier * ZombRand(_stage.hoursMinimum, _stage.hoursMaximum + 1)
	end
end

function SWWS_Core.GetCurrentSchedule()
	for scheduleKey, schedule in ipairs(SWWS_Schedules.pool) do
		if schedule.id == SWWS_Data.saveData.scheduleId then
			return schedule
		end
	end
end

function SWWS_Core.FillBroadcastWarning()

	local result = {
		color = { r = 1.0, g = 1.0, b = 1.0 },
		overridePower = nil,
		overrideForcast = nil,
		overrideChoppah = nil,
		isShutdown = false,
		diagnostic = getRadioText("AEBS_ConditionNominal"),
	}

	if not SWWS_Core.isInitialized then
		if SWWS_Debug.logging then
			print("SWWS: FillBroadcastWarning ignored, SWWS_Core.isInitialized is false")
		end
		return result
	end

	local messages = nil

	if SWWS_Data.saveData.systemRepairComplete then
		messages = SWWS_Schedules.stages.repaired
	else
		local schedule = SWWS_Core.GetCurrentSchedule()
		local stage = schedule.stages[SWWS_Data.saveData.stageIndex]
		messages = stage.messages
	end

	if messages then
		result.color = messages.statusColor
	else
		-- Not sure why, but messages is sometimes nil, probably an off by one error somewhere.
		print("SWWS: Error, messages was unexpectedly nil for id "..SWWS_Data.saveData.scheduleId..", index "..SWWS_Data.saveData.stageIndex)
	end


	result.isShutdown = messages.failureChance == 100


	if not result.isShutdown then
		if ZombRand(1, 100) <= messages.failureChance then
			result.overridePower = getRadioText("AEBS_KnoxPowerGridStatusUnavailable")
		end

		if ZombRand(1, 100) <= messages.failureChance then
			result.overrideForcast = getRadioText("AEBS_ForcastOffline")
		end

		if ZombRand(1, 100) <= messages.failureChance then
			result.overrideChoppah = getRadioText("AEBS_AirTrafficRadarDisabled")
		end
	end

	result.diagnostics = {
		SWWS_Core.PopulateDiagnostic(getRadioText(messages.status[ZombRand(1, #messages.status + 1)]))
	}

	if messages.revealTime then
		local shutdown = nil
		if SWWS_Data.saveData.stageRemaining < 2 then
			shutdown = getRadioText("AEBS_EmergencyShutdownImminent"):gsub("{fuzz}", SWWS_Strings.fuzzs[ZombRand(1, #SWWS_Strings.fuzzs + 1)])

		elseif SWWS_Data.saveData.stageRemaining < 24 then
			shutdown = getRadioText("AEBS_EmergencyShutdownInHours"):gsub("{hours}", tostring(SWWS_Data.saveData.stageRemaining))

		else
			shutdown = getRadioText("AEBS_EmergencyShutdownInDays"):gsub("{days}", tostring(math.floor(SWWS_Data.saveData.stageRemaining / 24)))

		end
		table.insert(result.diagnostics, shutdown)
	end

	if messages.requestCrew then
		for repairKey, repair in ipairs(SWWS_Data.saveData.systemRepairInstructions) do
			table.insert(result.diagnostics, repair)
		end
	end

	return result
end

function SWWS_Core.PopulateDiagnostic(_diagnostic)
	_diagnostic = _diagnostic:gsub("{condition}", SWWS_Data.saveData.conditionLower)
	_diagnostic = _diagnostic:gsub("{Condition}", SWWS_Data.saveData.conditionUpper)
	_diagnostic = _diagnostic:gsub("{system}", SWWS_Data.saveData.systemName)
	_diagnostic = _diagnostic:gsub("{fuzz}", SWWS_Strings.fuzzs[ZombRand(1, #SWWS_Strings.fuzzs + 1)])
	return _diagnostic
end
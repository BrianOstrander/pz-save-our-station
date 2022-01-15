require "radio/SWWS_SystemFaults"
require "radio/SWWS_Schedules"
require "radio/SWWS_Strings"
require "SWWS_Config"
require "SWWS_Data"

SWWS_Core = {}

function SWWS_Core.Initialize()

    if SWWS_Core.isInitialized then
        return
    end

    if SWWS_Config.debug.logging then
        print("SWWS: Initializing Weather Stations")
    end

    SWWS_Data.Load()

    if SWWS_Config.debug.forceInitialize or not SWWS_Data.saveData then
        SWWS_Config.debug.forceInitialize = false
        if SWWS_Config.debug.logging then
            print("SWWS: saveData nil, initializing")
        end
        SWWS_Data.saveData = {}
        SWWS_Core.ScheduleFailure()
    end

    SWWS_Core.isInitialized = true

    SWWS_Data.Save()
end

function SWWS_Core.OnEveryHour()
    SWWS_Core.Initialize()
    SWWS_Core.UpdateFailure()
    
    SWWS_Data.Save()
end
Events.EveryHours.Add(SWWS_Core.OnEveryHour)

function SWWS_Core.ScheduleFailure()

    if not SWWS_Locations then
        print("SWWS: Error, no locations have been defined!")
        return
    elseif SWWS_Config.debug.logging then
        print("SWWS: Locations contains " .. #SWWS_Locations .. " entries")
    end

    local poolChanceResult = ZombRand(1, SWWS_Config.gameplay.poolChanceNominal + SWWS_Config.gameplay.poolChanceFatal + 1)

    local poolResult = SWWS_Schedules.poolTypes.fatal

    if SWWS_Config.debug.forceFatal then
        if SWWS_Config.debug.logging then
            print("SWWS: Pool chosen: forced " .. poolResult)
        end
    else
        if poolChanceResult < SWWS_Config.gameplay.poolChanceNominal then
            poolResult = SWWS_Schedules.poolTypes.nominal
        end

        if SWWS_Config.debug.logging then
            print("SWWS: Pool chosen: " .. poolResult)
        end
    end

    local poolIndices = {}

    for i,v in ipairs(SWWS_Schedules.pool) do
        if v.poolType == poolResult then
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

    if SWWS_Config.debug.logging then
        print("SWWS: Location " .. SWWS_Data.saveData.locationId .. ", Schedule " .. SWWS_Data.saveData.scheduleId .. ", Stage " .. SWWS_Data.saveData.stageIndex .. ", StageRemaining " .. SWWS_Data.saveData.stageRemaining)
        print("SWWS: System " .. SWWS_Data.saveData.systemName .. ", Repair " .. SWWS_Data.saveData.systemRepair.description)
        print("SWWS: -------")
    end
end

function SWWS_Core.UpdateFailure()
    
    if not SWWS_Locations then
        print("SWWS: Error, no locations have been defined!")
        return
    end

    if SWWS_Config.debug.ignoreRequirePowerShutoff then
        if SWWS_Config.debug.logging then
            print("SWWS: Ignoring requirements for power shutoff")
        end
    else
        if SWWS_Config.gameplay.requirePowerShutoff then
            if getGameTime():getNightsSurvived() < getSandboxOptions():getElecShutModifier() then
                if SWWS_Config.debug.logging then
                    print("SWWS: Power not shutoff - skipping failure update")
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
                if SWWS_Config.debug.logging then
                    print("SWWS: Progressed to stage #" .. SWWS_Data.saveData.stageIndex .. " of " .. SWWS_Data.saveData.scheduleId)
                    print("SWWS: Stage length is " .. SWWS_Data.saveData.stageRemaining .. " hours")
                end
            elseif schedule.poolType ~= SWWS_Schedules.poolTypes.fatal then
                -- This was not a fatal fault, schedule the next failure...
                SWWS_Core.ScheduleFailure()
            end
        elseif SWWS_Config.debug.logging then
            print("SWWS: Stage remaining " .. SWWS_Data.saveData.stageRemaining .. " hours")
        end
    end
end

function SWWS_Core.GenerateStageRemaining(stage)
    if SWWS_Config.debug.forceMinimumTime then
        SWWS_Data.saveData.stageRemaining = 1

        if SWWS_Config.debug.logging then
            print("SWWS: Forced stageRemaining to " .. SWWS_Data.saveData.stageRemaining)
        end
    else
        SWWS_Data.saveData.stageRemaining = SWWS_Config.gameplay.timeMultiplier * ZombRand(stage.hoursMinimum, stage.hoursMaximum + 1)
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
        if SWWS_Config.debug.logging then
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

    result.color = messages.statusColor

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
            shutdown = getRadioText("AEBS_EmergencyShutdownImminent")
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
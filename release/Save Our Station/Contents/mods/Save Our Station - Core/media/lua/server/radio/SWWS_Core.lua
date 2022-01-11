require "radio/SWWS_SystemFaults"
require "radio/SWWS_Schedules"
require "radio/SWWS_Strings"
require "radio/SWWS_Config"

SWWS_Core = {}

function SWWS_Core.OnGameStart()
    if SWWS_Config.debug.logging then
        print("SWWS: Initializing Weather Stations")
    end

    local gametime = GameTime:getInstance()

    SWWS_Core.Load(gametime)

    if SWWS_Config.debug.forceInitialize or not SWWS_Core.saveData then
        SWWS_Config.debug.forceInitialize = false
        if SWWS_Config.debug.logging then
            print("SWWS: saveData nil, initializing")
        end
        SWWS_Core.saveData = {}
        SWWS_Core.ScheduleFailure()
    end

    SWWS_Core.isInitialized = true
end
Events.OnGameStart.Add(SWWS_Core.OnGameStart)

function SWWS_Core.OnEveryHour()
    local gametime = GameTime:getInstance()

    SWWS_Core.UpdateFailure()
    
    SWWS_Core.Save(gametime)
end
Events.EveryHours.Add(SWWS_Core.OnEveryHour)

function SWWS_Core.ScheduleFailure()

    if not SWWS_Locations then
        print("SWWS: Error, no locations have been defined!")
        return
    elseif SWWS_Config.debug.logging then
        print("SWWS: Locations contains " .. #SWWS_Locations .. " entries")
    end

    local gametime = GameTime:getInstance()

    local poolChanceResult = ZombRand(1, SWWS_Config.gameplay.poolChanceNominal + SWWS_Config.gameplay.poolChanceFatal + 1)

    local poolResult = SWWS_Schedules.poolTypes.fatal

    if poolChanceResult < SWWS_Config.gameplay.poolChanceNominal then
        poolResult = SWWS_Schedules.poolTypes.nominal
    end

    if SWWS_Config.debug.logging then
        print("SWWS: Pool chosen - " .. poolResult)
    end

    local poolIndices = {}

    for i,v in ipairs(SWWS_Schedules.pool) do
        if v.poolType == poolResult then
            table.insert(poolIndices, i)
        end
    end

    local schedule = SWWS_Schedules.pool[poolIndices[ZombRand(1, #poolIndices + 1)]]
    local location = SWWS_Locations[ZombRand(1, #SWWS_Locations + 1)]

    SWWS_Core.saveData.locationId = location.id
    SWWS_Core.saveData.locationRoomName = location.roomName

    SWWS_Core.saveData.scheduleId = schedule.id
    SWWS_Core.saveData.stageIndex = 1

    local stage = schedule.stages[1]

    SWWS_Core.saveData.stageRemaining = SWWS_Config.gameplay.timeMultiplier * ZombRand(stage.hoursMinimum, stage.hoursMaximum + 1)
    
    SWWS_Core.saveData.conditionLower = SWWS_Localization.GetLine(SWWS_Strings.conditions[ZombRand(1, #SWWS_Strings.conditions + 1)])
    SWWS_Core.saveData.conditionUpper = SWWS_Core.saveData.conditionLower:gsub("^%l", string.upper)
    
    local system = SWWS_SystemFaults.pool[ZombRand(1, #SWWS_SystemFaults.pool + 1)]
    SWWS_Core.saveData.systemId = SWWS_Localization.GetLine(system.id)
    SWWS_Core.saveData.systemRepair = system.repairs[ZombRand(1, #system.repairs + 1)]
    SWWS_Core.saveData.systemRepairComplete = false;

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

    SWWS_Core.saveData.systemName = SWWS_Core.saveData.systemId .. "_" .. serial

    -- gsub returns a table, so we do this to avoid random numbers getting added to our table.
    local repairInstructionLocation = SWWS_Localization.GetLine("AEBS_LocationRequiresUtilCrewDispatch"):gsub("{location}", location.id)
    local repairInstructionCode = SWWS_Localization.GetLine("AEBS_DiagnosticCode"):gsub("{code}", SWWS_Core.saveData.systemRepair.solution.code):gsub("{system}", SWWS_Core.saveData.systemName):gsub("{description}", SWWS_Localization.GetLine(SWWS_Core.saveData.systemRepair.description))

    SWWS_Core.saveData.systemRepairInstructions = {
        repairInstructionLocation,
        repairInstructionCode
    }

    SWWS_Core.Save(gametime)

    if SWWS_Config.debug.logging then
        print("SWWS: Location " .. SWWS_Core.saveData.locationId .. ", Schedule " .. SWWS_Core.saveData.scheduleId .. ", Stage " .. SWWS_Core.saveData.stageIndex .. ", StageRemaining " .. SWWS_Core.saveData.stageRemaining)
        print("SWWS: System " .. SWWS_Core.saveData.systemName .. ", Repair " .. SWWS_Core.saveData.systemRepair.description)
        print("SWWS: -------")
    end
end

function SWWS_Core.UpdateFailure()
    
    if not SWWS_Locations then
        print("SWWS: Error, no locations have been defined!")
        return
    end

    if SWWS_Config.gameplay.requirePowerShutoff then
        if getGameTime():getNightsSurvived() < getSandboxOptions():getElecShutModifier() then
            if SWWS_Config.debug.logging then
                print("SWWS: Power not shutoff - skipping failure update")
            end
            return
        end
    end
    
    if SWWS_Core.saveData.systemRepairComplete then
        SWWS_Core.ScheduleFailure()
        return
    end

    local schedule = SWWS_Core.GetCurrentSchedule()
    local stage = schedule.stages[SWWS_Core.saveData.stageIndex]
    
    if 0 < SWWS_Core.saveData.stageRemaining then
        SWWS_Core.saveData.stageRemaining = SWWS_Core.saveData.stageRemaining - 1

        if SWWS_Core.saveData.stageRemaining == 0 then
            if SWWS_Core.saveData.stageIndex < #schedule.stages then
                SWWS_Core.saveData.stageIndex = SWWS_Core.saveData.stageIndex + 1 
                stage = schedule.stages[SWWS_Core.saveData.stageIndex]
                SWWS_Core.saveData.stageRemaining = SWWS_Config.gameplay.timeMultiplier * ZombRand(stage.hoursMinimum, stage.hoursMaximum + 1)
                if SWWS_Config.debug.logging then
                    print("SWWS: Progressed to stage #" .. SWWS_Core.saveData.stageIndex .. " of " .. SWWS_Core.saveData.scheduleId)
                    print("SWWS: Stage length is " .. SWWS_Core.saveData.stageRemaining .. " hours")
                end
            elseif schedule.poolType ~= SWWS_Schedules.poolTypes.fatal then
                -- This was not a fatal fault, schedule the next failure...
                SWWS_Core.ScheduleFailure()
            end
        elseif SWWS_Config.debug.logging then
            print("SWWS: Stage remaining " .. SWWS_Core.saveData.stageRemaining .. " hours")
        end
    end
end

function SWWS_Core.GetCurrentSchedule()
    for scheduleKey, schedule in ipairs(SWWS_Schedules.pool) do
        if schedule.id == SWWS_Core.saveData.scheduleId then
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
        diagnostic = SWWS_Localization.GetLine("AEBS_ConditionNominal"),
    }

    if not SWWS_Core.isInitialized then
        return result
    end

    local messages = nil

    if SWWS_Core.saveData.systemRepairComplete then
        messages = SWWS_Schedules.stages.repaired
    else
        local schedule = SWWS_Core.GetCurrentSchedule()
        local stage = schedule.stages[SWWS_Core.saveData.stageIndex]
        messages = stage.messages
    end

    result.color = messages.statusColor

    result.isShutdown = messages.failureChance == 100

    if not result.isShutdown then
        if ZombRand(1, 100) <= messages.failureChance then
            result.overridePower = SWWS_Localization.GetLine("AEBS_KnoxPowerGridStatusUnavailable")
        end
        
        if ZombRand(1, 100) <= messages.failureChance then
            result.overrideForcast = SWWS_Localization.GetLine("AEBS_ForcastOffline")
        end

        if ZombRand(1, 100) <= messages.failureChance then
            result.overrideChoppah = SWWS_Localization.GetLine("AEBS_AirTrafficRadarDisabled")
        end
    end

    result.diagnostics = {
        SWWS_Core.PopulateDiagnostic(SWWS_Localization.GetLine(messages.status[ZombRand(1, #messages.status + 1)]))
    }

    if messages.revealTime then
        local shutdown = nil
        if SWWS_Core.saveData.stageRemaining < 2 then
            shutdown = SWWS_Localization.GetLine("AEBS_EmergencyShutdownImminent")
        elseif SWWS_Core.saveData.stageRemaining < 24 then
            shutdown = SWWS_Localization.GetLine("AEBS_EmergencyShutdownInHours"):gsub("{hours}", tostring(SWWS_Core.saveData.stageRemaining))
        else
            shutdown = SWWS_Localization.GetLine("AEBS_EmergencyShutdownInDays"):gsub("{days}", tostring(math.floor(SWWS_Core.saveData.stageRemaining / 24)))
        end
        table.insert(result.diagnostics, shutdown)
    end

    if messages.requestCrew then
        for repairKey, repair in ipairs(SWWS_Core.saveData.systemRepairInstructions) do
            table.insert(result.diagnostics, repair)
        end
    end

    return result
end

function SWWS_Core.PopulateDiagnostic(_diagnostic)
   _diagnostic = _diagnostic:gsub("{condition}", SWWS_Core.saveData.conditionLower)
   _diagnostic = _diagnostic:gsub("{Condition}", SWWS_Core.saveData.conditionUpper)
   _diagnostic = _diagnostic:gsub("{system}", SWWS_Core.saveData.systemName)
   _diagnostic = _diagnostic:gsub("{fuzz}", SWWS_Strings.fuzzs[ZombRand(1, #SWWS_Strings.fuzzs + 1)])
   return _diagnostic
end

function SWWS_Core.Save(_gametime)
    _gametime:getModData()["swws_saveData"] = SWWS_Core.saveData
end

function SWWS_Core.Load(_gametime)
    SWWS_Core.saveData = _gametime:getModData()["swws_saveData"]
end

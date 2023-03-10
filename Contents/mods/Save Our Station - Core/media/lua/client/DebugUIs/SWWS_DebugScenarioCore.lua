debugScenarios = debugScenarios or {}

SWWS_DebugScenarios = {}

function SWWS_DebugScenarios.EveryOneMinute()
    if GameTime:getInstance() then
        -- Cleanup Zombies if we've moved far away from where we last were.
        local minutes = GameTime:getInstance():getMinutes()
        local playerPosition = { x = getPlayer():getX(), y = getPlayer():getY() }
        local playerDistance = PZMath.max(PZMath.abs(playerPosition.x - SWWS_DebugScenarios.playerPosition.x), PZMath.abs(playerPosition.y - SWWS_DebugScenarios.playerPosition.y))

        if SWWS_DebugScenarios.playerDistanceThreshold < playerDistance or (minutes and minutes == 1) then
            SWWS_DebugScenarios.CleanupZombies()
        end
        
        SWWS_DebugScenarios.playerPosition = playerPosition
    end
end

function SWWS_DebugScenarios.OnAddWalkieTalkie(_item)
    ISTimedActionQueue.add(ISEquipWeaponAction:new(getPlayer(), _item, 20, true, false))
    ISTimedActionQueue.add(ISRadioAction:new("ToggleOnOff",getPlayer(), _item))
    ISTimedActionQueue.add(ISRadioAction:new("SetChannel",getPlayer(), _item, DynamicRadio.cache[WeatherChannel.channelUUID]:GetFrequency()))
end

function SWWS_DebugScenarios.CleanupZombies()
    local radius = 50
    if isClient() then
        SendCommandToServer(string.format("/removezombies -x %d -y %d -z %d -radius %d", getPlayer():getX(), getPlayer():getY(), getPlayer():getZ(), radius))
        return
    end
    for x = (getPlayer():getX() - radius), (getPlayer():getX() + radius) do
        for y= (getPlayer():getY() - radius), (getPlayer():getY() + radius) do
            local square = getCell():getGridSquare(x, y, getPlayer():getZ())
            if square then
                for i = square:getMovingObjects():size(), 1, -1 do
                    local zombie = square:getMovingObjects():get(i - 1)
                    if instanceof(zombie, "IsoZombie") then
                        zombie:removeFromWorld()
                        zombie:removeFromSquare()
                    end
                end
            end
        end
    end
end

function SWWS_DebugScenarios.SetSandbox()
    SandboxVars.DayLength                                   = 1       -- 15 minutes
    SandboxVars.VehicleEasyUse                              = true
    SandboxVars.TimeSinceApo                                = 5       -- 4 months
    SandboxVars.ElecShutModifier                            = -1
    SandboxVars.ElecShut                                    = 1       -- Instant
    SandboxVars.Zombies                                     = 5       -- None
    SandboxVars.ZombieConfig.PopulationMultiplier           = 0       -- None
    SandboxVars.Map = {
        AllowMiniMap                                        = false,
        AllowWorldMap                                       = true,
        MapAllKnown                                         = true,
    }
    SandboxVars.SaveOurStationCore.ReliabilityProfile       = 5       -- Lost Cause
    SandboxVars.SaveOurStationCore.TimeDurationMultiplier   = 1       -- 12x
end

function SWWS_DebugScenarios.OnStart()
    getPlayer():setGodMod(true)
    getPlayer():setUnlimitedCarry(true)
    getPlayer():setNoClip(true)
    getPlayer():setInvisible(true)
    ISFastTeleportMove.cheat = true

    for _, itemEntry in ipairs(SWWS_DebugScenarios.items) do
        local item = getPlayer():getInventory():AddItem(itemEntry.id)
        if itemEntry.OnAddItem then
            itemEntry.OnAddItem(item)
        end
    end

    for i = 1, 10 do
        getPlayer():LevelPerk(Perks.Woodwork)
        getPlayer():LevelPerk(Perks.Mechanics)
        getPlayer():LevelPerk(Perks.Electricity)
    end

    getPlayer():getKnownRecipes():add("Generator")

    Events.EveryOneMinute.Add(SWWS_DebugScenarios.EveryOneMinute)
end

function SWWS_DebugScenarios.Initialize()

    local defaultScenarios = {}

    for scenario_key, scenario in pairs(debugScenarios) do
        defaultScenarios[scenario_key] = scenario
        debugScenarios[scenario_key] = nil
    end

    for index, scenario in ipairs(SWWS_DebugScenarios.scenarios) do
        debugScenarios["swws_debug_scenario_"..index] = {
            name = "SWWS - "..scenario.name,
            startLoc = scenario.location,
            setSandbox = SWWS_DebugScenarios.SetSandbox,
            onStart = SWWS_DebugScenarios.OnStart
        }
    end

    for scenario_key, scenario in pairs(defaultScenarios) do
        debugScenarios[scenario_key] = scenario
    end 
end

-- Last player position
SWWS_DebugScenarios.playerPosition = { x = 0, y = 0 }
-- How far they can move in 1 minute before we do a cleanup
SWWS_DebugScenarios.playerDistanceThreshold = 1000

SWWS_DebugScenarios.items = {
    { id = "WristWatch_Right_DigitalBlack" },
    { 
        id = "Radio.WalkieTalkie5",
        OnAddItem = SWWS_DebugScenarios.OnAddWalkieTalkie,
    },
}

SWWS_DebugScenarios.scenarios = {
    {
        name = "Zulu",
        location = {x=6464, y=11889, z=0 },
    },
}

SWWS_DebugScenarios.Initialize()
if debugScenarios == nil then
    debugScenarios = {}
end

debugScenarios.SWWS_DebugScenarioCore = {
    name = "Save Our Station Debug Core",
    startLoc = {x=6464, y=11889, z=0 }, -- zulu
    setSandbox = function()
        SandboxVars.VehicleEasyUse = true
        SandboxVars.Zombies = 5
    end,
    onStart = function()
        getPlayer():setGodMod(true)
        getPlayer():setUnlimitedCarry(true)
        getPlayer():setNoClip(true)
        ISFastTeleportMove.cheat = true
        ISWorldMap.setHideUnvisitedAreas(false)
        getPlayer():getInventory():AddItem("WristWatch_Right_DigitalBlack")
        local walkie = getPlayer():getInventory():AddItem("Radio.WalkieTalkie5")
        ISTimedActionQueue.add(ISEquipWeaponAction:new(getPlayer(), walkie, 20, true, false))
        ISTimedActionQueue.add(ISRadioAction:new("ToggleOnOff",getPlayer(), walkie))
        ISTimedActionQueue.add(ISRadioAction:new("SetChannel",getPlayer(), walkie, DynamicRadio.cache[WeatherChannel.channelUUID]:GetFrequency()))
    end
}

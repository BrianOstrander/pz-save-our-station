if debugScenarios == nil then
    debugScenarios = {}
end

debugScenarios.SWWS_DebugScenarioVehicle = {
    name = "Save Our Station Debug Vehicle",
    startLoc = {x=6464, y=11889, z=0 }, -- zulu
    setSandbox = function()
        SandboxVars.VehicleEasyUse = true
        SandboxVars.Zombies = 5
        SandboxVars.Map.AllKnown = true
    end,
    onStart = function()
        getPlayer():setGodMod(true)
        getPlayer():setUnlimitedCarry(true)
        getPlayer():setNoClip(true)
        ISFastTeleportMove.cheat = true
        getPlayer():getInventory():AddItem("WristWatch_Right_DigitalBlack")
        local walkie = getPlayer():getInventory():AddItem("Radio.WalkieTalkie5")
        print("Emergency Broadcast Frequency: "..DynamicRadio.cache[WeatherChannel.channelUUID]:GetFrequency())

        -- Events.OnMouseUp.Add(
        --     function()
        --         -- reload vehicle textures here?
        --     end
        -- )
    end
}

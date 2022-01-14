require "SWWS_Config"

SWWS_Data = {}

function SWWS_Data.IsSinglePlayer()
    return not isClient() and not isServer()
end

function SWWS_Data.Save()
	if SWWS_Config.debug.logging then
        print("SWWS: SWWS_Data.Save")
    end

    GameTime:getInstance():getModData()["swws_saveData"] = SWWS_Data.saveData

    if not SWWS_Data.IsSinglePlayer() then
        if SWWS_Config.debug.logging then
            print("SWWS: ModData.add & ModData.transmit")
        end
        ModData.add("swws_saveData", SWWS_Data.saveData)
        ModData.transmit("swws_saveData")
    end
end

function SWWS_Data.Load()
	if SWWS_Data.IsSinglePlayer() then
        -- Singleplayer
        if SWWS_Config.debug.logging then
            print("SWWS: SWWS_Data.Load as Singleplayer")
        end
        SWWS_Data.saveData = GameTime:getInstance():getModData()["swws_saveData"]
    elseif isServer() then        
        -- Dedicated Server
        if SWWS_Config.debug.logging then
            print("SWWS: SWWS_Data.Load as Dedicated Server")
        end
        ModData.add("swws_saveData", GameTime:getInstance():getModData()["swws_saveData"])
        SWWS_Data.saveData = ModData.get("swws_saveData")
    else
        -- Client
        if SWWS_Config.debug.logging then
            print("SWWS: SWWS_Data.Load as Client")
        end
        SWWS_Data.saveData = ModData.get("swws_saveData")
    end
end

function SWWS_Data.OnReceiveGlobalModData(key, modData)
    if key == "swws_saveData" and modData then
        if isServer() then
            if SWWS_Data.saveData and modData and SWWS_Data.saveData.systemRepairComplete ~= modData.systemRepairComplete then
                if not SWWS_Data.saveData.systemRepairComplete then
                    if SWWS_Config.debug.logging then
                        print("SWWS: Server recieved client transmission setting systemRepairComplete to true")
                    end
                    SWWS_Data.saveData.systemRepairComplete = true
                    SWWS_Data.Save()
                end
            elseif SWWS_Config.debug.logging then
                print("SWWS: Server recieved client transmission, but value from client ignored")
            end
        elseif isClient() then
            if SWWS_Config.debug.logging then
                print("SWWS: Client recieved server transmission")
            end
            ModData.add(key, modData)
        end 
    end
end
Events.OnReceiveGlobalModData.Add(SWWS_Data.OnReceiveGlobalModData)
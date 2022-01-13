require "SWWS_Config"

SWWS_Data = {}

-- shared

function SWWS_Data.IsSinglePlayer()
    return not isClient() and not isServer()
end

function SWWS_Data.Save()
	if SWWS_Config.debug.logging then
        print("SWWS: SWWS_Data.Load")
    end

    GameTime:getInstance():getModData()["swws_saveData"] = SWWS_Data.saveData

    if not SWWS_Data.IsSinglePlayer() then
        ModData.transmit("swws_saveData")
    end
end

function SWWS_Data.Load()
	if SWWS_Config.debug.logging then
        print("SWWS: SWWS_Data.Load")
    end

    if SWWS_Data.IsSinglePlayer() then
        -- Singleplayer
        SWWS_Data.saveData = GameTime:getInstance():getModData()["swws_saveData"]
    elseif isServer() then
        -- Dedicated Server
        SWWS_Data.saveData = ModData.add("swws_saveData", GameTime:getInstance():getModData()["swws_saveData"])
    else
        -- Client
        SWWS_Data.saveData = ModData.get("swws_saveData")
    end
end

function SWWS_Data.OnReceiveGlobalModData(key, modData)
    if key == "swws_saveData" then
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

-- function SWWS_Core.OnReceiveGlobalModData(key, modData)
--     if key == "swws_saveData" then
--         if SWWS_Data.saveData and modData and SWWS_Data.saveData.systemRepairComplete ~= modData.systemRepairComplete then
--             if not SWWS_Data.saveData.systemRepairComplete then
--                 if SWWS_Config.debug.logging then
--                     print("SWWS: Client set systemRepairComplete to true")
--                 end
--                 SWWS_Data.saveData.systemRepairComplete = true
--                 SWWS_Data.Save()
--             end
--         elseif SWWS_Config.debug.logging then
--             print("SWWS: OnRecieveGlobalModData triggered, but value from client ignored")
--         end
--     end
-- end
-- Events.OnReceiveGlobalModData.Add(SWWS_Core.OnReceiveGlobalModData)

-- function SWWS_RepairContext.OnReceiveGlobalModData(key, modData)
-- 	if key == "swws_saveData" then
-- 		ModData.add(key, modData)
-- 	end 
-- end
-- Events.OnReceiveGlobalModData.Add(SWWS_RepairContext.OnReceiveGlobalModData)

-- from server core
-- function SWWS_Core.Save()
--     if SWWS_Config.debug.logging then
--         print("SWWS: SWWS_Core.Save")
--     end

--     GameTime:getInstance():getModData()["swws_saveData"] = SWWS_Core.saveData
--     ModData.transmit("swws_saveData")
-- end

-- function SWWS_Core.Load()
--     if SWWS_Config.debug.logging then
--         print("SWWS: SWWS_Core.Load")
--     end

--     SWWS_Core.saveData = GameTime:getInstance():getModData()["swws_saveData"]
--     SWWS_Core.saveData = ModData.add("swws_saveData", SWWS_Core.saveData)
-- end

-- -- from client repaircontext
-- function SWWS_RepairContext.Save()
-- 	ModData.transmit("swws_saveData")
-- end

-- function SWWS_RepairContext.Load()
-- 	SWWS_RepairContext.saveData = ModData.get("swws_saveData")
-- end

require "SWWS_Debug"
require "SWWS_Data"

SWWS_RepairContext = {}

function SWWS_RepairContext.itemValid(item)
	return not item:isBroken()
end

function SWWS_RepairContext.fix(_player, _context, _worldObjects, _test)

	local roomName = nil
	
	for i,v in ipairs(_worldObjects) do
		local square = v:getSquare()
		local room = square:getRoom()
		if room then
			roomName = room:getName()
			break
		end
	end

	if not roomName then
		return
	end

	SWWS_Data.Load()

	if SWWS_Data.saveData == nil then
		if SWWS_Debug.logging then
			print("SWWS: SWWS_Data.saveData is nil")
		end
		return
	end

	if not SWWS_Data.saveData or SWWS_Data.saveData.systemRepairComplete or not SWWS_Data.saveData.locationId then
		return
	end

	if roomName ~= SWWS_Data.saveData.locationRoomName then
		return
	end

	local repairOption = _context:addOption(getText("ContextMenu_RepairAutomatedBroadcast"), nil, SWWS_RepairContext.onSelectRoot)
	local subMenuRepair = ISContextMenu:getNew(_context)
	_context:addSubMenu(repairOption, subMenuRepair);

	local playerObject = getSpecificPlayer(_player)
	local playerInventoryItems = playerObject:getInventory():getItems()

	for repairItemTypeIndex, repairItemType in ipairs(SWWS_Data.saveData.systemRepair.solution.items) do
		local repairItemName = getItemNameFromFullType(repairItemType)
		if repairItemName then
			local onRepairItem = function()
				SWWS_RepairContext.onSelectItem(playerObject, repairItemType)
			end
			local itemOption = subMenuRepair:addOption(repairItemName, nil, onRepairItem)
			itemOption.notAvailable = true

			for inventoryIndex = 1, playerInventoryItems:size() do
				local inventoryItem = playerInventoryItems:get(inventoryIndex - 1)
				if inventoryItem:getFullType() == repairItemType then
					itemOption.notAvailable = false
					break
				end
			end
		end
	end
end
Events.OnPreFillWorldObjectContextMenu.Add(SWWS_RepairContext.fix)

function SWWS_RepairContext.onSelectRoot()
	-- Nothing right now...
end

function SWWS_RepairContext.onSelectItem(_playerObject, _itemType)
	local playerInventory = _playerObject:getInventory()
	local item = playerInventory:getFirstTypeEvalRecurse(_itemType, SWWS_RepairContext.itemValid)

	local primaryItem = _playerObject:getPrimaryHandItem()

	if primaryItem and primaryItem:getFullType() == _itemType then
		_playerObject:removeFromHands(primaryItem)
	end
	
	ISTimedActionQueue.add(SWWS_RepairAction:new(_playerObject, item, 300));
end
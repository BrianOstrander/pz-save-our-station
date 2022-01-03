require "TimedActions/ISBaseTimedAction"

SWWS_RepairAction = ISBaseTimedAction:derive("SWWS_RepairAction");

SWWS_RepairAction.drainables = {
    {
        full = "Base.PetrolCan",
        empty = "Base.EmptyPetrolCan"
    },
    {
        full = "Base.PropaneTank",
        empty = nil
    },
    {
        full = "Base.Extinguisher",
        empty = nil
    }
}

function SWWS_RepairAction:isValid()
	return self.character:getInventory():contains(self.item);
end

function SWWS_RepairAction:update()
    self.character:setMetabolicTarget(Metabolics.HeavyWork);
end

function SWWS_RepairAction:start()
	self:setActionAnim(CharacterActionAnims.BuildLow)
end

function SWWS_RepairAction:stop()
    ISBaseTimedAction.stop(self);
end

function SWWS_RepairAction:perform()
    SWWS_RepairContext.saveData.systemRepairComplete = true
    SWWS_RepairContext.Save(GameTime:getInstance())

    local container = self.item:getContainer()
    local itemType = self.item:getFullType()

    if SWWS_RepairContext.saveData.systemRepair.solution.consumeItem then
        self:removeItem()
    elseif SWWS_RepairContext.saveData.systemRepair.solution.drainItem then
        for i,v in ipairs(SWWS_RepairAction.drainables) do
            if itemType == v.full then
                self:removeItem()
                if v.empty then
                    container:AddItem(v.empty);
                end
                break
            end
        end
    end

    container:setDrawDirty(true);

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function SWWS_RepairAction:removeItem()
    self.hotbar.chr:removeAttachedItem(self.item)
	self.item:setAttachedSlot(-1)
	self.item:setAttachedSlotType(nil)
    self.item:setAttachedToModel(nil)
    self.character:getInventory():RemoveOneOf(self.item:getFullType())
	self.hotbar:reloadIcons()
end

function SWWS_RepairAction:new(_playerObject, _item, _time)
	local o = {}
	setmetatable(o, self)
	self.__index = self
    o.character = _playerObject;
    o.hotbar = getPlayerHotbar(_playerObject:getPlayerNum())
	o.stopOnWalk = true;
	o.stopOnRun = true;
	o.item = _item;
	o.maxTime = _time;
	if o.character:isTimedActionInstant() then
		o.maxTime = 1;
	end
	return o;
end

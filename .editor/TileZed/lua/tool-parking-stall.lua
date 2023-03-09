dofile(scriptDirectory..'/parking-stall.lua')

function activate()
    self:setCursorType(TileTool.EdgeTool)
end

function deactivate()
end

function mouseMoved(buttons, x, y, modifiers)
    self:clearToolTiles()
    if buttons.left and not self.cancel then
	local tiles = getTiles(x, y)
	for i=1,#tiles do
	    local t = tiles[i]
	    local tile = map:tile(t[4])
	    if tile then
		self:setToolTile(t[1], t[2], t[3], tile)
	    end
	end
    end
end

function mousePressed(buttons, x, y, modifiers)
    if buttons.left then
	self.cancel = false
	self.x, self.y = x, y
    end
    if buttons.right then
	self.cancel = true
	self:clearToolTiles()
    end
end

function mouseReleased(buttons, x, y, modifiers)
    if not buttons.left or self.cancel then return end
    self:clearToolTiles()
    local tiles = getTiles(x, y)
    for i=1,#tiles do
	local t = tiles[i]
	local layer = map:tileLayer(t[1])
	local tile = map:tile(t[4])
	if layer and tile then
	   layer:setTile(t[2], t[3], tile)
	else
	    if not layer then print('map is missing layer '..t[1]) end
	    if not tile then print('map is missing tile '..t[4]) end
	end
    end
    self:applyChanges('Draw Parking Stall')
end

function modifiersChanged(modifiers)
end

function keyPressed(key)
end

-- from GitHub Gist
function join_tables(t1, t2)
    for k,v in ipairs(t2) do table.insert(t1, v) end
    return t1
end

function getTiles(x, y)
    local ret = {}
    local dx = math.abs(x - self.x)
    local dy = math.abs(y - self.y)
    if dx > dy then
	if self.y - math.floor(self.y) < 0.5 then
	    if x > self.x then
		for x1=self.x,x,3 do
		    ret = join_tables( ret, north_parking_stall(x1,self.y) )
		end
	    else
		for x1=self.x-2,x,-3 do
		    ret = join_tables( ret, north_parking_stall(x1,self.y) )
		end
	    end
	else
	    if x > self.x then
		for x1=self.x,x,3 do
		    ret = join_tables( ret, south_parking_stall(x1,self.y) )
		end
	    else
		for x1=self.x-2,x,-3 do
		    ret = join_tables( ret, south_parking_stall(x1,self.y) )
		end
	    end
	end
    else
	if self.x - math.floor(self.x) < 0.5 then
	    if y > self.y then
		for y1=self.y,y,3 do
		    ret = join_tables( ret, west_parking_stall(self.x,y1) )
		end
	    else
		for y1=self.y-2,y,-3 do
		    ret = join_tables( ret, west_parking_stall(self.x,y1) )
		end
	    end
	else
	    if y > self.y then
		for y1=self.y,y,3 do
		    ret = join_tables( ret, east_parking_stall(self.x,y1) )
		end
	    else
		for y1=self.y-2,y,-3 do
		    ret = join_tables( ret, east_parking_stall(self.x,y1) )
		end
	    end
	end
    end
    return ret
end

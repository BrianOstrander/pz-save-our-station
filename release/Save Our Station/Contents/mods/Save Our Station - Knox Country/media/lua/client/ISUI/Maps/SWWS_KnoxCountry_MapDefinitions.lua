-- Had to copy this logic over from ISMapDefinitions.lua

SWWS_KnoxCountry_MapUtils = {}

function SWWS_KnoxCountry_MapUtils.initDirectoryMapData(mapUI, directory)
	local mapAPI = mapUI.javaObject:getAPIv1()
	local file = directory..'/worldmap-forest.xml'
	if fileExists(file) then
		mapAPI:addData(file)
	end
	file = directory..'/worldmap.xml'
	if fileExists(file) then
		mapAPI:addData(file)
	end

	-- This call indicates the end of XML data files for the directory.
	-- If map features exist for a particular cell in this directory,
	-- then no data added afterwards will be used for that same cell.
	mapAPI:endDirectoryData()

	mapAPI:addImages(directory)
end

local function overlayPNG(mapUI, x, y, scale, layerName, tex, alpha)
	local texture = getTexture(tex)
	if not texture then return end
	local mapAPI = mapUI.javaObject:getAPIv1()
	local styleAPI = mapAPI:getStyleAPI()
	local layer = styleAPI:newTextureLayer(layerName)
	layer:setMinZoom(0)
	layer:addFill(0, 255, 255, 255, (alpha or 1.0) * 255)
	layer:addTexture(0, tex)
	layer:setBoundsInSquares(x, y, x + texture:getWidth() * scale, y + texture:getHeight() * scale)
end

-- Adding actual map inits below.

LootMaps = LootMaps or {}
LootMaps.Init = LootMaps.Init or {}

LootMaps.Init.SWWS_KnoxCountry_Register = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	SWWS_KnoxCountry_MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	mapAPI:setBoundsInSquares(0, 0, 1396, 1735)
	overlayPNG(mapUI, 0, 0, 1, "lootMapPNG", "media/ui/content/swws_station_map_knox_country.png", 1.0)
end

LootMaps.Init.SWWS_KnoxCountry_RegisterAnnotated = function(mapUI)
	local mapAPI = mapUI.javaObject:getAPIv1()
	SWWS_KnoxCountry_MapUtils.initDirectoryMapData(mapUI, 'media/maps/Muldraugh, KY')
	mapAPI:setBoundsInSquares(0, 0, 1396, 1735)
	overlayPNG(mapUI, 0, 0, 1, "lootMapPNG", "media/ui/content/swws_station_map_knox_country_annotated.png", 1.0)
end

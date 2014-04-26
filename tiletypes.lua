tiletypes = {}

tiletypes.list = {}

function tiletypes.addTileType(tileNo, imagePath, passability)
	local t = {}
	t.number = tileNo
	t.image = love.graphics.newImage(imagePath)
	t.passable = passability
	--print(t.passable)
	tiletypes.list[tileNo] = t
	--print("tile "..tileNo.." added")
end

function tiletypes.getTileImage(tileType)
	return tiletypes.list[tileType].image
end

function tiletypes.getTileType(typeNo)
	return tiletypes.list[typeNo]
end

tiletypes.addTileType(1, "res/gfx/tiles/unknown.png",false)
tiletypes.addTileType(2, "res/gfx/tiles/ground_grey.png", true)
tiletypes.addTileType(3, "res/gfx/tiles/ground_brown.png",true)
tiletypes.addTileType(4, "res/gfx/tiles/ground_orange.png",true)

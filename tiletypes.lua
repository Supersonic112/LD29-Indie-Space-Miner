tiletypes = {}

tiletypes.list = {}

function tiletypes.addTileType(tileNo, imagePath)
	local t = {}
	t.image = love.graphics.newImage(imagePath)
	tiletypes.list[tileNo] = t
	--print("tile "..tileNo.." added")
end

function tiletypes.getTileImage(tileType)
	return tiletypes.list[tileType].image
end

tiletypes.addTileType(1, "res/gfx/tiles/tile1.png")
tiletypes.addTileType(2, "res/gfx/tiles/tile1.png")
tiletypes.addTileType(3, "res/gfx/tiles/tile1.png")
tiletypes.addTileType(4, "res/gfx/tiles/tile1.png")

tiles = {}

function tiles.getTile(tileType)
	local t = {}
		t.tileType = tiletypes.getTileType(tileType)
		t.getImage = function()
			return tiletypes.getTileImage(t.tileType.number)
		end
		t.getTileType = function()
			return t.tileType
		end
	return t
end

function getTile(getTileType)
	local t = {}
		t.tileType = getTileType
		t.getImage = function()
			return tiletypes.getTileImage(t.tileType)
		end
	return t
end

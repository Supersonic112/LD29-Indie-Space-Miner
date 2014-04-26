require "area"

function getGame()
	local t = {}
	t.area = getArea()
	t.area.createMap()
	return t
end

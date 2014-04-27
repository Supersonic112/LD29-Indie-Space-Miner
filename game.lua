require "area"
function getGame()
	local t = {}
	t.area = getArea()
	t.area.changeMapSize(13,10)
	t.score = 0
	
	-- game control logic
	t.movePlayer = function(dX, dY)
		t.moveObj("player", dX, dY)
	end
	
	t.modifyScore = function(dSc)
		t.score = t.score+dSc
	end
	t.moveObj = function(objectIdentifier, dX, dY)
		objects.changePosition(objectIdentifier, dX, dY)
	end
	
	return t
end

require "tiles"
-- where the game is being played
function getArea()
	local t = {}
	t.map = {}
	t.lengthX = 5
	t.lengthY = 5
	t.changeMapSize = function(newLengthX,newLengthY)
		t.lengthX,t.lengthY = newLengthX,newLengthY
		t.createMap()
	end
	t.createMap = function()
		for i = 1, t.lengthX do
			t.map[i] = {}
			for j=1,t.lengthY do
				t.map[i][j] = getTile(1)
			end
		end
	end
	
	--t.getTile
	
	t.init = function()
		t.buildArea()
	end
	
	t.buildArea = function()
		for i=1,t.lengthX do
			for j=1,t.lengthY do
				t.map[i][j] = getTile(love.ism.rng:random(1,3))
			end
		end
	end
	return t
end

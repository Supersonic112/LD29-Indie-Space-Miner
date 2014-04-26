-- where the game is being played
function getArea()
	local t = {}
	t.map = {}
	t.lengthX = 1
	t.lengthY = 1
	t.changeMapSize = function(newLengthX,newLengthY)
		t.lengthX,t.lengthY = newLengthX,newLengthY
		t.createMap()
	end
	t.createMap = function()
		for i=1,lengthX do
			for j=1,lengthY do
				t.map[i][j] = 0
			end
		end
	end
	t.init = function()
	
		t.buildArea()
	end
	t.buildArea = function()
	for i=1,lengthX do
		for j=1,lengthY do
			t.map[i][j] = love.ism.rng:random(1,16)
		end
	end
	end
	return t
end

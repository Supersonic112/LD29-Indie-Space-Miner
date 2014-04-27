require "tiles"
require "objects"
-- where the game is being played
function getArea(sizeX, sizeY)
	local t = {}
	t.map = {}
	t.lengthX = sizeX or 6
	t.lengthY = sizeY or 8
	t.resourcePercentage = love.math.random(t.lengthX*t.lengthY*0.8,t.lengthX*t.lengthY)
	t.changeMapSize = function(newLengthX,newLengthY)
		t.lengthX,t.lengthY = newLengthX,newLengthY
		t.createMap()
		t.buildArea()
	end
	
	t.createMap = function()
		for i = 1, t.lengthX do
			t.map[i] = {}
			for j=1,t.lengthY do
				if i==1 or j ==1 or i ==t.lengthX or j == t.lengthY then
					t.map[i][j] = tiles.getTile(1)
				else
					t.map[i][j] = tiles.getTile(3)
				end
			end
		end
	end
	
	t.getTile = function(posX, posY)
		posX = math.floor(posX+0.5)
		posY = math.floor(posY+0.5)
		print(posX)
		print(posY)
		return t.map[posX][posY]
	end	
	
	t.getObjects = function(posX, posY)
		return objects.getFromPosition(posX,posY)--t.objMap[posX][posY]
	end
	
	t.init = function(sizeX, sizeY)
		t.createMap(sizeX, sizeY)
		t.buildArea()
	end
	
	t.buildArea = function()
		for i=1,t.lengthX do
			for j=1,t.lengthY do
				if i==1 or j ==1 or i ==t.lengthX or j == t.lengthY then
					t.map[i][j] = tiles.getTile(1)
				else
					t.map[i][j] = tiles.getTile(love.math.random(2,4))
				end
			end
		end
		t.addResources()
	end
	
	t.addResources = function()
		--determine amount of each resource to be spread
		local resIron = 0.5*t.resourcePercentage
		local resBronze = 0.3*t.resourcePercentage
		local resGold = 0.1*t.resourcePercentage
		local resPlatinum = 0.05*t.resourcePercentage
		--TODO: add ore objects to game world
	end
	
	t.playerInteract = function()
		local v = objects.getPlayer()
		local posX,posY = v.posX+v.facingDirection[1],v.posY+v.facingDirection[2]
		local k = t.getObjects(posX, posY)
			if k == nil then
				return
			else
				for _,i in pairs(k) do
					if i.mineable then
						print("trying to interact")
						i.mine()
					end
				end
			end
	end
	
	t.possibleMove = function(destX, destY)
		if not t.getTile(destX,destY).getTileType().passable then 
			return false
		else
			local k = t.getObjects(destX,destY)
			if k == nil then
				return true
			else
				for _,i in pairs(k) do
					if not i.passable then
						return false
					end
				end
			end
		return true
		end
	end
	
	return t
end

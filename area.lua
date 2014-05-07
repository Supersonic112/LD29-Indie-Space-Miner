require "tiles"
require "objects"
-- where the game is being played
function getArea(sizeX, sizeY)
	local t = {}
	t.map = {}
	t.lengthX = sizeX or 6
	t.lengthY = sizeY or 8
	t.caveInMap = {} -- stability
	t.caveInState = {}
	t.caveInStatus = {special = 5, reinforced = 5, stable = 4, cracked = 2, broken = 1}
	t.caveIns = 0
	t.resourcePercentage = love.math.random(t.lengthX*t.lengthY*0.6,t.lengthX*t.lengthY)
	t.changeMapSize = function(newLengthX,newLengthY)
		t.lengthX,t.lengthY = newLengthX,newLengthY
		t.createMap()
		t.buildArea()
	end
	
	t.createMap = function()
		for i = 1, t.lengthX do
			t.map[i] = {}
			t.caveInMap[i] = {}
			t.caveInState[i] = {}
			for j=1,t.lengthY do
				if i==1 or j ==1 or i ==t.lengthX or j == t.lengthY then
					t.map[i][j] = tiles.getTile(5)
					t.caveInMap[i][j] = t.caveInStatus["reinforced"]
					t.caveInState[i][j] = 10
				else
					t.map[i][j] = tiles.getTile(3)
					t.caveInMap[i][j] = t.caveInStatus["stable"]
				end
			end
		end
	end
	
	t.getTile = function(posX, posY)
		posX = math.floor(posX+0.5)
		posY = math.floor(posY+0.5)
		return t.map[posX][posY]
	end	
	
	t.getObjects = function(posX, posY)
		return objects.getFromPosition(posX,posY)
	end
	
	t.init = function(sizeX, sizeY)
		objects.resetList()
		t.createMap(sizeX, sizeY)
		t.buildArea()
		t.caveIns = 0
		t.watchEnvironment()
	end
	
	t.buildArea = function()
		for i=1,t.lengthX do
			for j=1,t.lengthY do
				if i==1 or j ==1 or i ==t.lengthX or j == t.lengthY then
					t.map[i][j] = tiles.getTile(5)
				else
					t.map[i][j] = tiles.getTile(love.math.random(3,4))
				end
			end
		end
		t.addResources()
	end
	
	t.addResources = function()
		--determine amount of each resource to be spread
		local resIron = love.math.random(1,1000)/100*t.resourcePercentage
		local resBronze = love.math.random(1,500)/100*t.resourcePercentage
		local resGold = love.math.random(1,200)/100*t.resourcePercentage
		local resPlatinum = love.math.random(1,150)/100*t.resourcePercentage
		-- adding ore objects to game world
		for i = 1, #t.map do
			for j = 1, #t.map[1] do
				if not (i <= 4 and j <= 4 or i==1 or i == t.lengthX or j ==1 or j == t.lengthY) and love.math.random(1,100)>10 then
					local r = love.math.random(1,t.lengthX*t.lengthY)
					local drops = {}
					--adding rubble
					if love.math.random(1,4) == 1 then
						drops[1]=objects.addObject(love.math.random(11,12),false,"rubble",i,j,true, false, nil, false, 0)
					end
					--print("adding resources, "..resIron)
					if r >= resIron then
						for l = 1, math.floor(love.math.random(1,10)/6)+1 do
							drops[#drops+1] = objects.addObject(7,false, "iron_drop", i, j, true, false, nil, true, 10)
						end
					elseif r >= resBronze then
						for l = 1, math.floor(love.math.random(1,100)/75)+1 do
							drops[#drops+1] = objects.addObject(8,false, "bronze_drop", i, j, true, false, nil, true, 50)
						end
					elseif r >= resGold then
						for l = 1, math.floor(love.math.random(1,100)/80)+1 do
							drops[#drops+1] = objects.addObject(9,false, "gold_drop", i, j, true, false, nil, true, 250)
						end
					elseif r >= resPlatinum then
						for l = 1, math.floor(love.math.random(1,100)/80)+1 do
							drops[#drops+1] = objects.addObject(9,false, "gold_drop", i, j, true, false, nil, true, 250)
						end
					end
					objects.addObject(love.math.random(5,6), true, "wall", i,j,false,true,drops)
					t.caveInMap[i][j] = t.caveInStatus["stable"]
				else
					if i<=4 and j<=4 then
						t.caveInMap[i][j] = t.caveInStatus["special"]
					else
					t.caveInMap[i][j] = t.caveInStatus["broken"]
					end
				end
			end
		end
	end
	
	t.playerInteract = function()
		local v = objects.getPlayer()
		local posX,posY = v.posX+v.facingDirection[1],v.posY+v.facingDirection[2]
		local k = t.getObjects(posX, posY)
			if k == nil then
				return
			else
				for _,i in pairs(k) do
					if i.canBeMined then
						--print("trying to interact")
						i.mine()
					end
				end
			end
	end
	
	t.changeCaveInMap = function(posX, posY, status)
		t.caveInMap[posX][posY] = status
	end
	
	t.playerPassiveInteract = function()
		local v = objects.getPlayer()
		local k = t.getObjects(v.posX, v.posY)
			if k ~= nil then --and #k>0 then
				--print("found something to collect, "..#k)--..k[1].name)
				for _,i in pairs(k) do
					if i.canBeCollected and i.visible then
					print (i.objectNo..", "..tostring(i.visible))
						i.collect()
					end
				end
			end
	end
	
	t.watchEnvironment = function()
		if t.caveInMap[1][1] ~= nil then
			for i = 2, #t.caveInMap-1 do
				for j = 2, #t.caveInMap[1]-1 do
					--print(t.caveInMap[i][j+1])
					t.caveInState[i][j] = t.caveInMap[i][j]+t.caveInMap[i-1][j]+t.caveInMap[i+1][j]+t.caveInMap[i][j-1]+t.caveInMap[i][j+1]
					if t.caveInState[i][j]<6 then
						t.caveIn(i,j)
					--eleif t.caveInState[i][j]<7 then
					end
				end
			end
		end
	end
	
	t.getCaveInDanger = function()
		local pPosX, pPosY = objects.getPlayer().posX, objects.getPlayer().posY
		if t.caveInState[pPosX][pPosY] then
			if t.caveInState[pPosX][pPosY]>10 then
				return "harmless"
			elseif t.caveInState[pPosX][pPosY]>9 then
				return "watch your step"
			elseif t.caveInState[pPosX][pPosY]>8 then
				return "medium risk"
			elseif t.caveInState[pPosX][pPosY]>7 then
				return "CAVE-IN IMMINENT!"
			else
				return "DANGER!"
			end
		else
			return "status unknown"
		end
	end
	
	t.caveIn = function(x,y)
		local objectsList = objects.getFromPosition(x,y)
		t.caveIns = t.caveIns+1
		if objects.getPlayer().posX ==x and objects.getPlayer().posY == y then
			love.ism.lastEndReason = 1
			love.ism.setGameState(love.ism.gameStates["game_over"])
		else
			objects.addObject(5, true, "wall", x, y, false, true)
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
					if i.visible and not i.passable then
						return false
					end
				end
			end
			return true
		end
	end
	
	return t
end

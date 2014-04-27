require "objecttypes"

objects = {}
objects.list = {}
TILE_SIZE = 64

function objects.getObject(id)
	return objects.list[id]
end

function objects.addObject(objType, objVisible, objName, xPos, yPos, passability, canBeMined, drops)
	local t = {}
	t.objectNo = #objects.list+1
	t.objectType = objecttypes.list[objType]--getObjectType(objType)
	t.visible = objVisible
	t.name = objName
	t.drops = drops
	t.facingDirection = {1,0} -- field at which the object looks in relation to its position
	t.mineable = canBeMined or false
	if t.mineable then
		t.mine = function()
			t.visible = false
			if t.drops then
				
			else
				objects.addObject(7,true, "iron_drop", t.posX, t.posY, true, false, nil)--workaround for now
			end
		end
	else
		t.mine = function ()
			return false
		end
	end
	if passability == nil then
	t.passable = t.objectType.passable
	else
	t.passable = passability
	end
	t.getObjectType = function()
		return t.objectType
	end
	t.posX, t.posY = xPos, yPos
	t.movementSpeed = 20
	t.graphicX, t.graphicY = xPos*TILE_SIZE, yPos*TILE_SIZE
	t.destX, t.destY = xPos, yPos
	objects.list[t.objectNo] = t
end

function objects.changePosition(objectId, dX, dY)
	if type(objectId) == "string" then
		local t = objects.getFromName(objectId)
		objects.changePosition(t.objectNo,dX,dY)
	elseif type(objectId) == "number" then
		objects.list[objectId].facingDirection = {dX,dY}
		print("Looking at "..dX..", "..dY)
		if love.ism.game.area.possibleMove(objects.list[objectId].posX+dX, objects.list[objectId].posY+dY) then
			objects.list[objectId].destX = objects.list[objectId].posX+dX
			objects.list[objectId].destY = objects.list[objectId].posY+dY
		else
			print("invalid move "..objects.list[objectId].posX+dX..", "..objects.list[objectId].posY+dY)
		end
	end
end

function objects.deltaMove(deltaTime)
	for _,o in pairs(objects.list) do
		--if true then
		if o.graphicX/64 ~= o.destX or o.graphicY/64 ~= o.destY then
			o.graphicX,o.graphicY = (o.graphicX+(o.destX*64-o.graphicX)*0.2),(o.graphicY+(o.destY*64-o.graphicY)*0.2)
			if o.destX*64-o.graphicX<32 then
				o.posX = math.floor(o.graphicX/64+0.5)
			end
			if o.destY*64-o.graphicY<32 then
				o.posY = math.floor(o.graphicY/64+0.5)
			end
		end
		--else
			--o.posX,o.posY = o.destX, o.destY
			--o.graphicX,o.graphicY = o.destX*TILE_SIZE,o.destY*TILE_SIZE
		--end
	end
end
	
function objects.getFromPosition(x,y)
	local t = {}
	for _,i in pairs(objects.list) do
		if i.posY == y and i.posX == x then
			t[#t]=i
		end
	end
	return t
end

function objects.getPlayer()
	return objects.getObject(2) --object 2 shall always be the player
end

function objects.getFromName(name)
	local t = {}
	for _, o in pairs(objects.list) do
		if o.name == name then
			t = o
		end
	end
	if t == nil then
		print ("no objects found")
	end
	return t
end

function objects.resetList()
	objects.list = {}
	-- adding 'constant' objects
	objects.addObject(1, false, "nothing", 1, 1, true, false)
	objects.addObject(2, true, "player", 2, 2, true, false)
end

-- adding objects manually for now
objects.addObject(1, false, "nothing", 1, 1, true, false)
objects.addObject(2, true, "player", 2, 2, true, false)
objects.addObject(5, true, "wall1", 3, 2, false, true)
objects.addObject(5, true, "wall1", 6, 3, false, true)

require "objecttypes"

objects = {}
objects.list = {}
TILE_SIZE = 64
objects.status = {idle = 1, walking = 2, mining = 3}

function objects.getObject(id)
	return objects.list[id]
end

function objects.addObject(objType, objVisible, objName, xPos, yPos, passability, canBeMined, drops, canBeCollected, points, constitution)
	local t = {}
	t.objectNo = #objects.list+1
	t.objectType = objecttypes.list[objType]--getObjectType(objType)
	t.objectTypeNo = objType
	t.visible = objVisible
	t.name = objName
	t.drops = drops
	if not constitution then t.maxConst = 100 else t.maxConst = constitution end
	t.curConst = t.maxConst
	t.status = objects.status["idle"]
	t.canBeCollected = canBeCollected or false
	if points == nil or not t.canBeCollected then
		t.points = 0
		t.collect = function()
			return false
		end
	else 
		t.points = points
		t.collect = function()
			if t.visible then
				love.ism.game.modifyScore(t.points)
				t.visible = false
			end
		end
	end
	t.activeImage = 1
	t.setActiveImage = function(newActive)
		if #t.objectType.image >= newActive then
			t.activeImage = newActive
		else
			print("this image does not exist")
		end
	end
	t.facingDirection = {1,0} -- field at which the object looks in relation to its position
	t.canBeMined = canBeMined or false
	if t.canBeMined and t.visible then
		t.mine = function()
			if t.curConst > 0 then
				t.curConst = t.curConst - 4
				
			else
				t.visible = false
				if t.drops ~= nil then
					for _,dr in pairs(t.drops) do
						objects.getObject(dr).visible = true
					end
				end
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
	return t.objectNo
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

function objects.getObjectImage(obj)
	return objecttypes.getObjectTypeImage(obj.objectTypeNo,obj.activeImage)
end

function objects.getFromPosition(x,y)
	local t = {}
	for _,i in pairs(objects.list) do
		if i.posY == y and i.posX == x and i.objectNo>2 and i.visible then
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
	for k in pairs(objects.list) do
		objects.list[k] = nil
	end
	-- adding 'constant' objects
	objects.addObject(1, false, "nothing", 1, 1, true, false)
	objects.addObject(2, true, "player", 2, 2, true, false)
end

-- adding objects manually for now
objects.addObject(1, false, "nothing", 1, 1, true, false)
objects.addObject(objecttypes.typelist["player"], true, "player", 2, 2, true, false)
objects.addObject(5, true, "wall1", 3, 2, false, true)

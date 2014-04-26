require "objecttypes"

objects = {}
objects.list = {}

function objects.getObject(id)
	return objects.list[id]
end

function objects.addObject(objType, objVisible, objName, xPos, yPos, passability)
	local t = {}
	t.objectNo = #objects.list+1
	t.objectType = objecttypes.list[objType]--getObjectType(objType)
	t.visible = objVisible
	t.name = objName
	if passability == nil then
	t.passable = t.objectType.passable
	else
	t.passable = passability
	end
	t.getObjectType = function()
		return t.objectType
	end
	t.posX, t.posY = xPos,yPos
	objects.list[t.objectNo] = t
end

function objects.changePosition(objectIdentifier, dX, dY)
		if type(objectIdentifier) == "string" then
			local t = objects.getFromName(objectIdentifier)
			objects.changePosition(t.objectNo,dX,dY)
		elseif type(objectIdentifier) == "number" then
			if love.ism.game.area.possibleMove(objects.list[objectIdentifier].posX+dX, objects.list[objectIdentifier].posY+dY) then
				objects.list[objectIdentifier].posX = objects.list[objectIdentifier].posX+dX
				objects.list[objectIdentifier].posY = objects.list[objectIdentifier].posY+dY
			else
				print("invalid move "..objects.list[objectIdentifier].posX+dX..", "..objects.list[objectIdentifier].posY+dY)
			end
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
end

-- adding objects manually for now
objects.addObject(1, false, "nothing", 1, 1, true)
objects.addObject(2, true, "player", 2, 2, true)
objects.addObject(5, true, "wall1", 3, 2, false)

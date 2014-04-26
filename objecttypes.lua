objecttypes = {}
objecttypes.list = {}
objecttypes.typelist = {nothing = 1, player = 2, asteroid_lander = 3, unknown = 4, rock = 5, rock2 = 6, iron = 7, gold = 8, platinum = 9}

function objecttypes.addObjectType(imgPath, objType, passability)
	local t = {}
	t.image = love.graphics.newImage(imgPath)
	if type(objType) == "string" then
	t.objectType = objecttypes.typelist[objType]
	elseif type(objType) == "number" then
	t.objectType = objType
	t.defaultPassable = passability
	end
	objecttypes.list[t.objectType] =t
	print ("Object type added: "..t.objectType)
end

function objecttypes.getObjectType(typeNo)
	return objecttypes.list[typeNo]
end

function objecttypes.getObjectImage(objectType)
	return objecttypes.list[objectType].image
end

objecttypes.addObjectType("res/gfx/obj/unknown.png",1, true)
objecttypes.addObjectType("res/gfx/obj/char_temp.png", 2, true)
objecttypes.addObjectType("res/gfx/obj/asteroidLander.png",3, false)
objecttypes.addObjectType("res/gfx/obj/unknown.png",4, false)
objecttypes.addObjectType("res/gfx/obj/rock_ore_grey.png",5, false)
objecttypes.addObjectType("res/gfx/obj/rock_ore_grey2.png",6, false)
objecttypes.addObjectType("res/gfx/obj/ore_iron.png",7, true)
objecttypes.addObjectType("res/gfx/obj/ore_gold.png",8, true)

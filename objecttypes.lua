objecttypes = {}
objecttypes.list = {}
objecttypes.typelist = {nothing = 1, player = 2, asteroid_lander = 3, unknown = 4, rock1 = 5, rock2 = 6, iron = 7, bronze = 8, gold = 9, platinum = 10, rubble1 = 11, rubble2 = 12}

function objecttypes.addObjectType(imgPath, objType, passability)
	local t = {}
	t.image = {}
	t.image[1] = love.graphics.newImage(imgPath[1])
	for i in pairs(imgPath) do
		t.image[i] = love.graphics.newImage(imgPath[i])
	end
	if type(objType) == "string" then
	t.objectType = objecttypes.typelist[objType]
	elseif type(objType) == "number" then
	t.objectTypeNo = objType
	end
	t.defaultPassable = passability
	objecttypes.list[t.objectTypeNo] =t
	print ("Object type added: "..t.objectTypeNo..", "..imgPath[1])
end

function objecttypes.getObjectType(typeNo)
	return objecttypes.list[typeNo]
end

function objecttypes.getObjectTypeImage(objectTypeNo, imageNo)
	--print("called with: ")
	--print(objectTypeNo)
	if objecttypes.list[objectTypeNo] then
		return objecttypes.list[objectTypeNo].image[imageNo or 1]
	else
		print("fallback used, this doesn't seem to exist:")
		print(objectTypeNo)
		return objecttypes.list[1].image[1]
	end
end

objecttypes.addObjectType({"res/gfx/obj/unknown.png"},1, true)
local charAnims = {"res/gfx/obj/char_d_idle.png", "res/gfx/obj/char_d1.png", "res/gfx/obj/char_d2.png", "res/gfx/obj/char_d_mining1.png", "res/gfx/obj/char_d_mining2.png"}
objecttypes.addObjectType(charAnims, 2, true)
objecttypes.addObjectType({"res/gfx/obj/asteroidLander.png"},3, false)
objecttypes.addObjectType({"res/gfx/obj/unknown.png"},4, false)
objecttypes.addObjectType({"res/gfx/obj/rock_ore_grey.png"},5, false)
objecttypes.addObjectType({"res/gfx/obj/rock_ore_grey2.png"},6, false)
objecttypes.addObjectType({"res/gfx/obj/ore_iron.png"},7, true)
objecttypes.addObjectType({"res/gfx/obj/ore_bronze.png"},8, true)
objecttypes.addObjectType({"res/gfx/obj/ore_gold.png"},9, true)
objecttypes.addObjectType({"res/gfx/obj/ore_platinum.png"},10, true)
objecttypes.addObjectType({"res/gfx/obj/rubble1.png"},11, true)
objecttypes.addObjectType({"res/gfx/obj/rubble2.png"},12, true)

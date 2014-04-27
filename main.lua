require "graphics"
require "game"
require "controls"
require "tiletypes"
require "objecttypes"

love.ism = {}
TILE_SIZE = 64
dtotal = 0

function love.load()
	love.ism.mainMenuFont = love.graphics.newFont(16) -- a custom font will be added as soon as I found a good one
	love.ism.reload()
end

function love.run()
	love.ism.gameStates = {initialization = 0, main_menu = 1, in_game = 2, game_over = 3, cutscene = 4, intro = 5, pause = 6}
	love.ism.gameState = love.ism.gameStates["initialization"]
	love.ism.pauseState = 1
	love.ism.game = getGame()
	if love.math then
		love.math.setRandomSeed(os.time())
		for i = 1, 50 do
			love.math.random()
		end
		love.math.setRandomSeed(love.math.random(1,2^26))
	end
	if love.event then
		love.event.pump()
	end
	if love.load then love.load(arg) end
	if love.timer then love.timer.step() end
	local dt = 0
	love.ism.setGameState("in_game")
	
	--main loop
	while true do
		if love.event then
			love.event.pump()
			for e,a,b,c,d in love.event.poll() do
				if e == "quit" then
					if not love.quit or not love.quit() then
						if love.audio then
							love.audio.stop()
						end
						return
					end
				end
				love.handlers[e](a,b,c,d)
			end
		end
		if love.timer then
			love.timer.step()
			dt = love.timer.getDelta()
		end
		if love.update then love.update(dt) end
		if love.window and love.graphics and love.window.isCreated() then
			love.graphics.clear()
			love.graphics.origin()
			if love.draw then love.draw() end
			love.graphics.present()
		end
		if love.timer then love.timer.sleep(0.001) end
	end
end

function love.update(dt)
	--local deltaTime = love.timer.getTime()-dtotal
	dtotal = dtotal + dt
	if dtotal >= 0.05 then
		dtotal = dtotal - 0.05
		objects.deltaMove(deltaTime)
		--print (dtotal)
		executeKeyActions()
	end
end

function math.normalize(x,y)
	local l=(x*x+y*y)^.5 if l==0 then return 0,0,0 else return x/l,y/l,l end
end

function love.ism.setGameState(newGameState)
	if type(newGameState)=="string" then
		love.ism.gameState = love.ism.gameStates[newGameState]
	elseif type(newGameState)=="number" and newGameState > 0 and newGameState <= 5 then
		love.ism.gameState = newGameState
	end
	love.ism.gameStateChanged()
end

-- this function makes sure that everything mentioned inside is notified if the game state changes
function love.ism.gameStateChanged()
	love.ism.graphics.initDrawing()
end

function love.ism.reload()
	love.ism.screenWidth, love.ism.screenHeight = love.window.getDimensions()
	love.ism.graphics = getGraphicsObject()
end

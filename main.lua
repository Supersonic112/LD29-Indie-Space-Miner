require "graphics"
require "game"

love.ism = {}
love.ism.gameStates = {initialization = 0, main_menu = 1, in_game = 2, game_over = 3, cutscene = 4, intro = 5}
love.ism.gameState = love.ism.gameStates["initialization"]
love.ism.game = getGame()
love.ism.rng = love.math.newRandomGenerator(os.time())
for i = 1, 50 do
	love.ism.rng:random()
end
love.ism.rng:setSeed(love.ism.rng:random(1,2^26))
function love.load()
	love.ism.mainMenuFont = love.graphics.newFont(16) -- a custom font will be added as soon as I found a good one
	love.ism.reload()
	love.ism.setGameState("in_game")
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

love.ld29game = {}

function love.load()
	mainmenufont = love.graphics.newFont(16) -- a custom font will be added as soon as I found a good one
	love.ld29game.reload()
end

function love.ld29game.reload()
	screenwidth, screenheight = love.window.getDimensions()
	canvas = love.graphics.newCanvas(screenwidth, screenheight, normal)
end

function love.draw()
	love.graphics.setFont(mainmenufont)
	love.graphics.print("LD 29 - Independent Space Miner", screenwidth/2-60, screenheight/10)
end

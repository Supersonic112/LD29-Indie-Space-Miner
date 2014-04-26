function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end
	if key == '1' then
		love.ism.setGameState(1)
	elseif key == '2' then
		love.ism.setGameState(2)
	end
	if key == 'up' then
		love.ism.game.movePlayer(0,-1)
	end
	if key == 'down' then
		love.ism.game.movePlayer(0,1)
	end
	if key == 'left' then
		love.ism.game.movePlayer(-1,0)
	end
	if key == 'right' then
		love.ism.game.movePlayer(1,0)
	end
	if key == 'p' then
		love.ism.setGameState(pause)
	end
	if key == 'a' then
		love.ism.graphics.scrollingOffsetX = love.ism.graphics.scrollingOffsetX - 1
	end
	if key == 'd' then
		love.ism.graphics.scrollingOffsetX = love.ism.graphics.scrollingOffsetX + 1
	end
	if key == 's' then
		love.ism.graphics.scrollingOffsetY = love.ism.graphics.scrollingOffsetY + 1
	end
	if key == 'w' then
		love.ism.graphics.scrollingOffsetY = love.ism.graphics.scrollingOffsetY - 1
	end
end

function love.mousepressed(x,y,button)
	if button == 'l' then
		print("left mouse key recognized")
	elseif button == 'r' then
		print("right mouse key recognized")
	end
end

love.keyboard.setKeyRepeat(true)
--function love.keypressed(key) -- depends on system settings for key repeat speed
function executeKeyActions() -- depends on love.update(dt)
	--old: if key == 'escape' then ...
	if love.keyboard.isDown('escape') then
		love.event.quit()
	end
	if love.keyboard.isDown('1') then
		love.ism.setGameState(1)
	elseif love.keyboard.isDown('2') then
		love.ism.setGameState(2)
	end
	if love.keyboard.isDown('up') then
		love.ism.game.movePlayer(0,-1)
	end
	if love.keyboard.isDown('down') then
		love.ism.game.movePlayer(0,1)
	end
	if love.keyboard.isDown('left') then
		love.ism.game.movePlayer(-1,0)
	end
	if love.keyboard.isDown('right') then
		love.ism.game.movePlayer(1,0)
	end
	if love.keyboard.isDown('p') then
		love.ism.setGameState(pause)
	end
	if love.keyboard.isDown('rctrl') or love.keyboard.isDown('lctrl') then
		love.ism.game.area.playerInteract() -- use drill
	end
	if love.keyboard.isDown('a') then
		love.ism.graphics.scrollingOffsetX = love.ism.graphics.scrollingOffsetX - 1
	end
	if love.keyboard.isDown('d') then
		love.ism.graphics.scrollingOffsetX = love.ism.graphics.scrollingOffsetX + 1
	end
	if love.keyboard.isDown('s') then
		love.ism.graphics.scrollingOffsetY = love.ism.graphics.scrollingOffsetY + 1
	end
	if love.keyboard.isDown('w') then
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

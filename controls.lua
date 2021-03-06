love.keyboard.setKeyRepeat(true)
function love.keypressed(key) -- only used for keys that should not be pressed for a longer period of time
	if key == 'escape' then
		love.event.quit()
	end
	if key == '1' then
		if love.ism.gameState == 1 then
			love.ism.restartGame()
			love.ism.setGameState(2)
		elseif love.ism.gameState == love.ism.gameStates["in_game"] then
			love.ism.lastEndReason = 3
			love.ism.setGameState(love.ism.gameStates["game_over"])
		elseif love.ism.gameState == love.ism.gameStates["game_over"] then
			love.ism.setGameState(1) -- go to main menu
		end
	--elseif key == '2' then
		--love.ism.setGameState(love.ism.gameStates["game_over"])
		--load game
	end
	if key == 'p' then
		if love.ism.gameState ~= 6 then
			love.ism.setGameState(6)--love.ism.gameStates["pause"])
		else
			love.ism.setGameState(7)--love.ism.gameStates["unpause"])
		end
	end
	if key == 'r' then
		love.ism.restartGame()
	end
end

function executeKeyActions() -- depends on love.update(dt)
	--old: if key == 'escape' then ...
	if not(love.ism.gameState == 6 or love.ism.gameState == 7) then
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
		if love.keyboard.isDown('rctrl') or love.keyboard.isDown('lctrl') then
			objects.getPlayer().setActiveImage(4)
			love.ism.game.area.playerInteract() -- use drill, this is called as long as ctrl is pressed
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
end

function love.mousepressed(x,y,button)
	if button == 'l' then
		print("left mouse key recognized")
	elseif button == 'r' then
		print("right mouse key recognized")
	end
end

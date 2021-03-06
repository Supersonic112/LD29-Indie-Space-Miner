function getGraphicsObject()
	local t = {}
	t.showFps = true
	
	t.initDrawing = function()
		t.dt = love.timer.getTime()
		t.scrollingOffsetX = 0
		t.scrollingOffsetY = 0
		t.mapCanvas = love.graphics.newCanvas()
		if love.ism.gameState == 1 then
			
		elseif love.ism.gameState == 2 then
			t.mapCanvas = love.graphics.newCanvas(love.ism.screenWidth, love.ism.screenHeight, normal)
			love.graphics.setCanvas(t.mapCanvas)
			for i = 1, love.ism.game.area.lengthX do
				for j = 1,love.ism.game.area.lengthY do
					if love.ism.game.area.map[i][j].getTileType().number >= 1 then
						x,y = love.ism.game.area.map[i][j].getImage():getDimensions()
						love.graphics.draw(tiletypes.list[love.ism.game.area.map[i][j].tileType.number].image,(i-1)*x,(j-1)*y)
					end
				end
			end
			love.graphics.setCanvas()
		end
	end
	
	function love.draw()
		if love.ism.gameState == 2 then --in game
			love.graphics.draw(t.mapCanvas,0+t.scrollingOffsetX*TILE_SIZE,0+t.scrollingOffsetY*TILE_SIZE)
			t.drawObjects()
			love.graphics.setFont(love.graphics.newFont(15))
			love.graphics.print("Score: "..love.ism.game.score, 5,40)
			love.graphics.print("Cave-in danger: "..love.ism.game.area.getCaveInDanger(), 5, 80)
		elseif love.ism.gameState == love.ism.gameStates["main_menu"] then
			love.graphics.draw(love.ism.titleScreen)
			love.graphics.setFont(love.ism.mainMenuFont)
			love.graphics.print("LD 29 - Indie Space Miner", 50,50)
			love.graphics.setFont(love.graphics.newFont(15))
			love.graphics.print("press '1' to start or to return to main menu", 50,200)
			love.graphics.print("move your character with the arrow keys", 50,225)
			--love.graphics.print("press '2' to load (NYI)", 50,225)
			--love.graphics.print("press '3' to show high scores", 50,250)
			love.graphics.print("hold 'ctrl' after walking towards a wall to mine it", 50,250)
			love.graphics.print("press 'p' to pause the game", 50,275)
			--love.graphics.print("press '4' to show credits", 50,275)
			love.graphics.print("press 'r' to restart the game", 50,300)
			love.graphics.print("press 'esc' to quit", 50,325)
			--story on the right side of the screen
		elseif love.ism.gameState == love.ism.gameStates["game_over"] then
			love.graphics.setFont(love.graphics.newFont(25))
			love.graphics.print("GAME OVER",love.window.getWidth()/2-100,50)
			love.graphics.print("Score: "..love.ism.game.score, love.window.getWidth()/2-80,150)
			love.graphics.setFont(love.graphics.newFont(18))
			if love.ism.lastEndReason and love.ism.lastEndReason > 0 and love.ism.lastEndReason <= #love.ism.endReasons then
				love.graphics.print(love.ism.endReasons[love.ism.lastEndReason], love.window.getWidth()/2-250,180)
			end
			love.graphics.setFont(love.graphics.newFont(12))
			love.graphics.print("Press '1' to return to the main menu", love.window.getWidth()/2-150,250)
		elseif love.ism.gameState == 6 then
			love.graphics.setFont(love.graphics.newFont(20))
			love.graphics.print("PAUSE, press 'p' to continue",love.window.getWidth()/3, 100)
		end
		if t.showFps then
			love.graphics.setFont(love.graphics.newFont(10))
			love.graphics.print("FPS: "..tostring(love.timer.getFPS()),5,5)
		end
	end
	
	t.drawObjects = function()
		if objects.list ~= nil then
			for o in pairs(objects.list) do
				if objects.list[o].visible and not (o == 2) then
					--print("object name:"..o)
					love.graphics.draw(
					objects.getObjectImage(objects.list[o]), (objects.list[o].graphicX+(t.scrollingOffsetX-1)*TILE_SIZE)+objects.list[o].objectType.imageOffsetX, (objects.list[o].graphicY+(t.scrollingOffsetY-1)*TILE_SIZE)+objects.list[o].objectType.imageOffsetY)
					--objecttypes.getObjectImage(objects.list[o].objectType.objectTypeNo), (objects.list[o].graphicX+(t.scrollingOffsetX-1)*TILE_SIZE), (objects.list[o].graphicY+(t.scrollingOffsetY-1)*TILE_SIZE))
				end
			end
			love.graphics.draw(objects.getObjectImage(objects.list[2]), (objects.list[2].graphicX+(t.scrollingOffsetX-1)*TILE_SIZE), (objects.list[2].graphicY+(t.scrollingOffsetY-1)*TILE_SIZE))
			--love.graphics.draw(objecttypes.getObjectImage(objects.list[2].objectType.objectTypeNo), (objects.list[2].graphicX+(t.scrollingOffsetX-1)*TILE_SIZE), (objects.list[2].graphicY+(t.scrollingOffsetY-1)*TILE_SIZE))
		end
	end
	return t
end

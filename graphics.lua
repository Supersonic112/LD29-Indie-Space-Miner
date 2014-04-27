function getGraphicsObject()
	local t = {}
	t.showFps = true
	
	t.initDrawing = function()
		--if not love.ism.gameState == love.ism.gameStates[pause] then
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
		--end
	end
	
	function love.draw()
		if love.ism.gameState == 2 then --in game
			love.graphics.draw(t.mapCanvas,0+t.scrollingOffsetX*TILE_SIZE,0+t.scrollingOffsetY*TILE_SIZE)
			t.drawObjects()
			love.graphics.print("Score: "..love.ism.game.score, 5,40)
		elseif love.ism.gameState == 1 then --main menu
			love.graphics.setFont(love.ism.mainMenuFont)
			love.graphics.print("LD 29 - Independent Space Miner", 50,50)--love.ism.screenwidth/2-120, love.ism.screenheight/10)
			love.graphics.setFont(love.graphics.newFont(15))
			love.graphics.print("press '1' to start", 50,200)
			love.graphics.print("press '2' to load (NYI)", 50,225)
			love.graphics.print("press '3' to show high scores (NYI)", 50,250)
			love.graphics.print("press 'esc' to quit", 50,275)
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
					objects.getObjectImage(objects.list[o]), (objects.list[o].graphicX+(t.scrollingOffsetX-1)*TILE_SIZE), (objects.list[o].graphicY+(t.scrollingOffsetY-1)*TILE_SIZE))
					--objecttypes.getObjectImage(objects.list[o].objectType.objectTypeNo), (objects.list[o].graphicX+(t.scrollingOffsetX-1)*TILE_SIZE), (objects.list[o].graphicY+(t.scrollingOffsetY-1)*TILE_SIZE))
				end
			end
			love.graphics.draw(objects.getObjectImage(objects.list[2]), (objects.list[2].graphicX+(t.scrollingOffsetX-1)*TILE_SIZE), (objects.list[2].graphicY+(t.scrollingOffsetY-1)*TILE_SIZE))
			--love.graphics.draw(objecttypes.getObjectImage(objects.list[2].objectType.objectTypeNo), (objects.list[2].graphicX+(t.scrollingOffsetX-1)*TILE_SIZE), (objects.list[2].graphicY+(t.scrollingOffsetY-1)*TILE_SIZE))
		end
	end
	return t
end

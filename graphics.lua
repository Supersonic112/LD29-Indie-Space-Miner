function getGraphicsObject()
	local t = {}
	t.showFps = true
	
	t.initDrawing = function()
		t.tileSize = 64
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
					if love.ism.game.area.map[i][j].tileType >= 1 then
						x,y = love.ism.game.area.map[i][j].getImage():getDimensions()
						love.graphics.draw(tiletypes.list[love.ism.game.area.map[i][j].tileType].image,(i-1)*x,(j-1)*y)
					end
				end
			end
			love.graphics.setCanvas()
		end
	end
	
	function love.draw()
		if love.ism.gameState == 2 then --in game
			love.graphics.draw(t.mapCanvas,0,0)
			t.drawObjects()
		elseif love.ism.gameState == 1 then --main menu
			love.graphics.setFont(love.ism.mainMenuFont)
			love.graphics.print("LD 29 - Independent Space Miner", 50,50)--love.ism.screenwidth/2-120, love.ism.screenheight/10)
		end
		if t.showFps then
			love.graphics.setFont(love.graphics.newFont(10))
			love.graphics.print("FPS:"..tostring(love.timer.getFPS()))
		end
	end
	
	t.drawObjects = function()
		
	end
	return t
end

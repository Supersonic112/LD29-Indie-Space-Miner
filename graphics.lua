function getGraphicsObject()
	local t = {}
	t.showFps = true
	t.initDrawing = function()
		if love.ism.gameState == 1 then
			
		elseif love.ism.gameState == 2 then
			t.canvas = love.graphics.newCanvas(love.ism.screenWidth, love.ism.screenHeight, normal)
		end
	end
	
	function love.draw()
		if t.showFps then
			love.graphics.setFont(love.graphics.newFont(10))
			love.graphics.print("FPS:"..tostring(love.timer.getFPS()))
		end
		if love.ism.gameState == 2 then --in game
			
		elseif love.ism.gameState == 1 then --main menu
			love.graphics.setFont(love.ism.mainMenuFont)
			love.graphics.print("LD 29 - Independent Space Miner", 50,50)--love.ism.screenwidth/2-120, love.ism.screenheight/10)
		end
	end
	
	return t
end

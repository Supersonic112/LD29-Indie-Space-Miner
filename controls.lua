function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end
	if key == '1' then
		love.ism.setGameState(1)
	elseif key == '2' then
		love.ism.setGameState(2)
	end
end

function love.mousepressed(x,y,button)
	if button == 'l' then
	print("left mouse key recognized")
	elseif button == 'r' then
	print("right mouse key recognized")
	end
end

function love.load()
	side_length = 450
	frame = {
		x = (lgw - side_length) / 2,
		y = (lgh - side_length) / 2
	}
end

function love.keypressed(key)
	if key == "r" then
		SwitchScene("Menu")
		step_number = 0
	elseif key == "escape" then
		SwitchScene("Menu")
	end
end

function love.draw()
	lg.setColor(1, 1, 1)
	lg.rectangle("fill", frame.x - 10, frame.y - 10, side_length + 20, side_length + 20, 20)
	SetFont(30)
	lg.setColor(0, 0, 0)
	lg.printf(step_number.." steps !", 0, lgh / 2 - 30, lgw, "center")
	lg.printf("Press R to restart", 0, lgh / 2 + 5, lgw, "center")
end

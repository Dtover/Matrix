function love.load()
	sm_button = Button:new((lgw - 200) / 2, 550, 200, 80, "Sliding Matrix", 25, {1, 1, 1}, {0, 0, 0})
	dhr_button = Button:new((lgw - 200) / 2, 650, 200, 80, "Digit HuaRong", 25, {1, 1, 1}, {0, 0, 0})
	exit_button = Button:new((lgw - 200) / 2, 830, 200, 80, "EXIT", 25, {1, 1, 1}, {0, 0, 0})
	level = Level:new((lgw - 220) / 2, 780, level_value, 2, 5)
end

function love.update()
end

function love.mousepressed(mx, my, button)
	if sm_button:isclick(mx, my, button) then
		SwitchScene("SlidingMatrix")
	elseif dhr_button:isclick(mx, my, button) then
		SwitchScene("DigitHuaRong")
	elseif exit_button:isclick(mx, my, button) then
		love.event.quit()
	elseif level:Min_bt_click(mx, my, button) then
		level.value = level.value - 1
	elseif level:Max_bt_click(mx, my, button) then
		level.value = level.value + 1
	end
	level_value = level.value
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end

function love.draw()
	SetFont(60)
	lg.setColor(1,1,1)
	lg.printf("Matrix", 0, 200, lgw, "center")
	sm_button:draw()
	dhr_button:draw()
	level:draw()
	exit_button:draw()
end

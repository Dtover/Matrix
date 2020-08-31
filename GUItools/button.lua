SetFont = SetFont

Button = {
	x = (lgw - 200) / 2,
	y = 100,
	w = 200,
	h = 80,
	text = "START GAME",
	text_size = 25,
	button_color = {1, 1, 1},
	text_color = {0, 0, 0}
}

function Button:new(x, y, w, h, text, text_size, button_color, text_color)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.x = x or 200
	o.y = y or 200
	o.w = w or 100
	o.h = h or 60
	o.text = text or "Button"
	o.text_size = text_size or 20
	o.text_color = text_color or {0, 0, 0}
	o.button_color = button_color or {1, 1, 1}
	return o
end

function Button:draw()
	text_height = SetFont(self.text_size)
	love.graphics.setColor(self.button_color)
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
	love.graphics.setColor(self.text_color)
	love.graphics.printf(self.text, self.x, self.y + (self.h - text_height) / 2, self.w, "center")
end

function Button:isclick(mx, my, button)
	if mx > self.x and mx < self.x + self.w and
	   my > self.y and my < self.y + self.h and button == 1 then
		return true
	end
end

return Button

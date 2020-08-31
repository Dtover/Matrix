Level = {}
lg = lg

function Level:new(x, y, value, min, max)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	self.x = x or 100
	self.y = y or 100
	self.value = value or min or 1
	self.min = min or 1
	self.max = max or 10
	return o
end

function Level:draw()
	lg.setColor(1, 1, 1)
	lg.rectangle("fill", self.x + 60, self.y - 25, 100, 50)
	lg.polygon("fill", self.x, self.y, self.x + 50, self.y - 25, self.x + 50, self.y + 25)
	lg.polygon("fill", self.x + 220, self.y, self.x + 170, self.y - 25, self.x + 170, self.y + 25)
	lg.setColor(0, 0, 0)
	lg.printf(tostring(self.value), self.x + 60, self.y - 25 + 8, 100, "center")
end

function Level:Min_bt_click(mx, my, bt)
	if 	my >= GetCurveFunc(self.x, self.y, self.x + 50, self.y - 25, mx) and
		my <= GetCurveFunc(self.x, self.y, self.x + 50, self.y + 25, mx) and
		mx >= self.x and mx <= (self.x + 50) and self.value > self.min
		and bt == 1 then
		return true
	end
end

function GetCurveFunc(x1, y1, x2, y2, x)
	if x1 ~= x2 then
		local y = (y2 - y1) * (x - x1) / (x2 - x1) + y1
		return y
	else
		return 0
	end
end

function Level:Max_bt_click(mx, my, bt)
	if 	my >= GetCurveFunc(self.x + 220, self.y, self.x + 170, self.y - 25, mx) and
		my <= GetCurveFunc(self.x + 220, self.y, self.x + 170, self.y + 25, mx) and
		mx >= self.x + 170 and mx <= (self.x + 220) and self.value < self.max
		and bt == 1 then
		return true
	end
end

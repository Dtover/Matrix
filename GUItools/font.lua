currentFontSize = 20
Fontlist = {}
default_font = love.graphics.newFont("font.ttf", currentFontSize)
love.graphics.setFont(default_font)
Fontlist[currentFontSize] = {
	font = default_font,
	height = default_font:getHeight("H")
}

function SetFont(size)
	if currentFontSize ~= size then
		if Fontlist[size] then
			love.graphics.setFont(Fontlist[size].font)
		else
			font = love.graphics.newFont("font.ttf", size)
			love.graphics.setFont(font)
			Fontlist[size] = {
				font = font,
				height = font:getHeight("H")
			}
		end
		currentFontSize = size
	end
	return Fontlist[size].height
end


lastgame  = "DigitHuaRong"
local level = level_value
local side_length = 450
local frame = {
	x = (lgw - side_length) / 2,
	y = (lgh - side_length) / 2
}
local frame = {
	x = (lgw - side_length) / 2,
	y = (lgh - side_length) / 2
}
local selectBoxPos = {
	x = frame.x,
	y = frame.y
}
-- This table help to locate the box position make its movement loop in a line
local count_value = {
	x = 0,
	y = 0
}
local puzzle_res = {
	{
		{1, 2},
		{3, 0}
	},
	{
		{1, 2, 3},
		{4, 5, 6},
		{7, 8, 0},
	},
	{
		{ 1,  2,  3,  4},
		{ 5,  6,  7,  8},
		{ 9, 10, 11, 12},
		{13, 14, 15,  0},
	},
	{
		{ 1,  2,  3,  4,  5},
		{ 6,  7,  8,  9, 10},
		{11, 12, 13, 14, 15},
		{16, 17, 18, 19, 20},
		{21, 22, 23, 24,  0},
	}
}
step_number = step_number
function love.load()
	puzzle_value = {
		{
			{1, 2},
			{3, 0}
		},
		{
			{1, 2, 3},
			{4, 5, 6},
			{7, 8, 0},
		},
		{
			{ 1,  2,  3,  4},
			{ 5,  6,  7,  8},
			{ 9, 10, 11, 12},
			{13, 14, 15,  0},
		},
		{
			{ 1,  2,  3,  4,  5},
			{ 6,  7,  8,  9, 10},
			{11, 12, 13, 14, 15},
			{16, 17, 18, 19, 20},
			{21, 22, 23, 24,  0},
		}
	}
	while CheckisCorrect() do
		Shuffle()
	end
end

function moveBox(axis, direction)
	count_value[axis] = (count_value[axis] + 1 * direction) % level
	selectBoxPos[axis] = frame[axis] + count_value[axis] * side_length / level
end

function moveDigit()
	z = GetZeroPos()
	if z then
		x = count_value.y + 1
		y = count_value.x + 1
		if puzzle_value[level - 1][x][y] ~= 0 and SwapValue(x, y, z[1], z[2]) then
			step_number = step_number + 1
		end
	end
end

function Shuffle()
	math.randomseed(os.time())
	local i = 0
	while (i < level * 10) do
		z = GetZeroPos()
		rtemp = math.random(1, 2)
		rv = math.random(1, level)
		if rtemp == 1 and rv ~= z[2] then
			SwapValue(z[rtemp], rv, z[1], z[2])
			i = i + 1
		elseif rtemp == 2 and rv ~= z[1] then
			SwapValue(rv, z[rtemp], z[1], z[2])
			i = i + 1
		end
	end
end

function GetZeroPos()
	for i = 1, level do
		for j = 1, level do
			if puzzle_value[level - 1][i][j] == 0 then
				return {i, j}
			end
		end
	end
end

function SwapValue(x, y, zx, zy)
	if x == zx then
		if zy > y then
			for i = zy, y + 1, -1 do
				puzzle_value[level - 1][x][i] = puzzle_value[level - 1][x][i - 1]
			end
		else
			for i = zy, y - 1 do
				puzzle_value[level - 1][x][i] = puzzle_value[level - 1][x][i + 1]
			end
		end
		puzzle_value[level - 1][x][y] = 0
		return true
	elseif y == zy then
		if zx > x then
			for i = zx, x + 1, -1 do
				puzzle_value[level - 1][i][y] = puzzle_value[level - 1][i - 1][y]
			end
		else
			for i = zx, x - 1 do
				puzzle_value[level - 1][i][y] = puzzle_value[level - 1][i + 1][y]
			end
		end
		puzzle_value[level - 1][x][y] = 0
		return true
	else
		return false
	end
end

function CheckisCorrect()
	for i = 1, level do
		for j = 1, level do
			if puzzle_value[level - 1][j][i] ~= puzzle_res[level - 1][j][i] then
				return false
			end
		end
	end
	return true
end

function love.keypressed(key)
	if key == "space" then
		moveDigit()
	end
	if key == "escape" then
		SwitchScene("Menu")
	end
	if key == "k" then
		moveBox("y", -1)
	end
	if key == "j" then
		moveBox("y", 1)
	end
	if key == "h" then
		moveBox("x", -1)
	end
	if key == "l" then
		moveBox("x", 1)
	end
end

function love.draw()
	if CheckisCorrect() ~= true then
		lg.setLineWidth(20)
		lg.setColor(1, 1, 1)
		lg.rectangle("line", frame.x, frame.y, side_length, side_length, 10)
		for i = 1, level - 1 do
			x = i * side_length / level
			lg.line(frame.x + x, frame.y, frame.x + x, frame.y + side_length)
			lg.line(frame.x, frame.y + x, frame.x + side_length, frame.y + x)
		end
		font_height = SetFont(200 / level)
		margin = frame.x / level + font_height / 4
		for i = 1, level do
			x = (i - 1) * side_length / level
			for j = 1, level do
				y = (j - 1) * side_length / level
				if puzzle_value[level - 1][j][i] ~= 0 then
					lg.printf(puzzle_value[level - 1][j][i], frame.x + x, frame.y + y + font_height / 2 - 10, side_length / level, "center")
				end
			end
		end
		-- Draw the select box
		lg.setColor(0, 0, 0)
		lg.setLineWidth(5)
		lg.rectangle("line", selectBoxPos.x, selectBoxPos.y, side_length / level, side_length / level, 5)
		lg.setColor(1, 1, 1)
		SetFont(50)
		lg.print("Steps: "..tostring(step_number), frame.x, frame.y - 100)
	else
		SwitchScene("FinPage")
	end
end

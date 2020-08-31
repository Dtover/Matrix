lastgame = "SlidingMatrix"
local level = level_value
local side_length = 450
-- game end control variable
local puzzle_res = {
	{
		{1, 2},
		{3, 4}
	},
	{
		{1, 2, 3},
		{4, 5, 6},
		{7, 8, 9},
	},
	{
		{ 1,  2,  3,  4},
		{ 5,  6,  7,  8},
		{ 9, 10, 11, 12},
		{13, 14, 15, 16},
	},
	{
		{ 1,  2,  3,  4,  5},
		{ 6,  7,  8,  9, 10},
		{11, 12, 13, 14, 15},
		{16, 17, 18, 19, 20},
		{21, 22, 23, 24, 25},
	}
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
step_number = step_number

function love.load()
	puzzle_value = {
		{
			{1, 2},
			{3, 4}
		},
		{
			{1, 2, 3},
			{4, 5, 6},
			{7, 8, 9},
		},
		{
			{ 1,  2,  3,  4},
			{ 5,  6,  7,  8},
			{ 9, 10, 11, 12},
			{13, 14, 15, 16},
		},
		{
			{ 1,  2,  3,  4,  5},
			{ 6,  7,  8,  9, 10},
			{11, 12, 13, 14, 15},
			{16, 17, 18, 19, 20},
			{21, 22, 23, 24, 25},
		}
	}
	while CheckisCorrect() do
		ShuffleMatrix()
	end
end

-- Shuffle the matrix
function ShuffleMatrix()
	math.randomseed(os.time())
	-- 20 steps shuffle
	for i = 1, 20 do
		a = math.random(0,1)
		b = math.random(0,1)
		if a == 0 then
			axis = "x"
		else
			axis = "y"
		end
		if b == 0 then
			direction = 1
		else
			direction = -1
		end
		moveBox(axis, direction)
		moveDigit(axis, direction)
	end
	-- Set the select box to the top left
	selectBoxPos = {
		x = frame.x,
		y = frame.y
	}
	count_value = {
		x = 0,
		y = 0
	}
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

function love.update()
end

-- Box movement
function moveBox(axis, direction)
	count_value[axis] = (count_value[axis] + 1 * direction) % level
	selectBoxPos[axis] = frame[axis] + count_value[axis] * side_length / level
end

-- Box width digit movement
function moveDigit(axis, direction)
	curpos = (selectBoxPos[axis] - frame[axis]) / side_length * level + 1
	if axis == "y" then
		if direction == 1 then
			temp = puzzle_value[level - 1][curpos][1]
			for i = 1, level - 1 do
				puzzle_value[level - 1][curpos][i] = puzzle_value[level - 1][curpos][i + 1]
			end
			puzzle_value[level - 1][curpos][level] = temp
		elseif direction == -1 then
			temp = puzzle_value[level - 1][curpos][level]
			for i = level, 2, -1 do
				puzzle_value[level - 1][curpos][i] = puzzle_value[level - 1][curpos][i - 1]
			end
			puzzle_value[level - 1][curpos][1] = temp
		end
	elseif axis == "x" then
		if direction == 1 then
			temp = puzzle_value[level - 1][1][curpos]
			for i = 1, level - 1 do
				puzzle_value[level - 1][i][curpos] = puzzle_value[level - 1][i + 1][curpos]
			end
			puzzle_value[level - 1][level][curpos] = temp
		elseif direction == -1 then
			temp = puzzle_value[level - 1][level][curpos]
			for i = level, 2, -1 do
				puzzle_value[level - 1][i][curpos] = puzzle_value[level - 1][i - 1][curpos]
			end
			puzzle_value[level - 1][1][curpos] = temp
		end
	end
end

function love.keypressed(key)
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
	if key == "a" then
		moveBox("x", -1)
		moveDigit("y", 1)
		step_number = step_number + 1
	end
	if key == "d" then
		moveBox("x", 1)
		moveDigit("y", -1)
		step_number = step_number + 1
	end
	if key == "w" then
		moveBox("y", -1)
		moveDigit("x", 1)
		step_number = step_number + 1
	end
	if key == "s" then
		moveBox("y", 1)
		moveDigit("x", -1)
		step_number = step_number + 1
	end
end

function love.draw()
	if CheckisCorrect() == false then
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
				lg.printf(puzzle_value[level - 1][j][i], frame.x + x, frame.y + y + font_height / 2 - 10, side_length / level, "center")
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

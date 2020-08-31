lg = love.graphics
lgw = lg.getWidth()
lgh = lg.getHeight()
level_value = 3
step_number = 0
lastgame = nil
end_time = 0

require("string")
require("GUItools/font")
require("GUItools/button")
require("GUItools/level")

function SwitchScene(scene)
	love.load = nil
	love.update = nil
	love.draw = nil
	love.keypressed = nil
	love.mousepressed = nil
	love.filesystem.load("scenes/"..scene..".lua")()
	love.load()
end

SwitchScene("Menu")

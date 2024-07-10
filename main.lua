love.graphics.setDefaultFilter("nearest", "nearest")

local Camera = require("lib.camera")
local Floor = require("lib.floor")
local Egg = require("lib.egg")

local camera
local floor
local egg

function love.load()
	egg = Egg()
	egg.y = -100
	camera = Camera()
	floor = Floor()
	camera.scale = 4
end

function love.update(dt)
	camera:update(dt)
	egg:update(dt)
end

function love.draw()
	love.graphics.setColor(1, 1, 1)
	love.graphics.clear(0.53, 0.81, 0.92)
	camera:draw(function()
		floor:draw(camera)
		egg:draw()
	end)
end

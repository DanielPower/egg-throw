love.graphics.setDefaultFilter("nearest", "nearest")

local Camera = require("lib.camera")
local Floor = require("lib.floor")
local Egg = require("lib.egg")
local physics = require("lib.physics")

local camera
local floor
local egg
local world

function love.load()
	love.physics.setMeter(64)
	world = love.physics.newWorld(0, 9.81 * 64, true)
	egg = Egg({ world = world, x = 0, y = -100 })
	egg.y = -100
	camera = Camera()
	floor = Floor({ world = world })
	camera.scale = 4
end

function love.update(dt)
	world:update(dt)
	camera:update(dt)
end

function love.draw()
	love.graphics.setColor(1, 1, 1)
	love.graphics.clear(0.53, 0.81, 0.92)
	camera:draw(function()
		floor:draw(camera)
		egg:draw()
		-- physics.debugDraw(world)
	end)
end

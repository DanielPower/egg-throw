love.graphics.setDefaultFilter("nearest", "nearest")

local Camera = require("lib.camera")
local Floor = require("lib.floor")
local Egg = require("lib.egg")
local physics = require("lib.physics")

local camera
local floor
local egg
local world
local entities = {}
local pause = false
local debug = false

function love.load()
	love.physics.setMeter(64)
	world = love.physics.newWorld(0, 9.81 * 64, true)
	camera = Camera({ y = -160, scale = 2 })
	table.insert(entities, Egg({ world = world, x = 0, y = -100 }))
	table.insert(entities, Egg({ world = world, x = 60, y = -100 }))
	table.insert(entities, Egg({ world = world, x = -30, y = -100 }))
	table.insert(entities, Floor({ world = world }))
	camera.target = entities[1]
end

function love.keypressed(key)
	if key == "p" then
		pause = not pause
	end
	if key == "d" then
		debug = not debug
	end
end

function love.mousepressed(x, y, button)
	if button == 1 then
		local wx, wy = camera:toWorld(x, y)
		table.insert(entities, Egg({ world = world, x = wx, y = wy }))
	end
end

function love.update(dt)
	if pause then
		return
	end
	world:update(dt)
	for _, entity in ipairs(entities) do
		if entity.update then
			entity:update(dt)
		end
	end
	camera:update(dt)
end

function love.draw()
	love.graphics.setColor(1, 1, 1)
	love.graphics.clear(0.53, 0.81, 0.92)
	camera:draw(function()
		for _, entity in ipairs(entities) do
			if entity.draw then
				entity:draw(camera)
			end
		end
		if debug then
			physics.debugDraw(world)
		end
	end)
	love.graphics.setColor(1, 0, 0)
	love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
end

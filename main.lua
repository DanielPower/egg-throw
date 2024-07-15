love.graphics.setDefaultFilter("nearest", "nearest")

local Throw = require("scenes.throw")

local scene
local pause = false
local debug = false

function love.load()
	love.physics.setMeter(64)
	scene = Throw()
end

function love.keypressed(key)
	if key == "p" then
		pause = not pause
	end
	if key == "d" then
		debug = not debug
	end
	if key == "r" then
		love.load()
	end
	if key == "escape" then
		love.event.quit()
	end
	scene.keypressed(key)
end

function love.mousepressed(x, y, button)
	scene.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
	scene.mousereleased(x, y, button)
end

function love.update(dt)
	if pause then
		return
	end
	scene.update(dt)
end

function love.draw()
	love.graphics.setColor(1, 1, 1, 1)
	scene.draw()
	scene.drawUI()
	if debug then
		love.graphics.setColor(1, 0, 0)
		love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
	end
end

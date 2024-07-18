love.graphics.setDefaultFilter("nearest", "nearest")

local Throw = require("scenes.throw")

function love.load()
	love.physics.setMeter(64)
	GAME_STATE = {
		scene = nil,
		pause = false,
		debug = false,
		hand_strength = 2000,
		money = 0,
	}
	GAME_STATE.scene = Throw()
end

function love.keypressed(key)
	if key == "p" then
		GAME_STATE.pause = not GAME_STATE.pause
	end
	if key == "d" then
		GAME_STATE.debug = not GAME_STATE.debug
	end
	if key == "r" then
		love.load()
	end
	if key == "escape" then
		love.event.quit()
	end
	GAME_STATE.scene.keypressed(key)
end

function love.mousepressed(x, y, button)
	GAME_STATE.scene.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
	GAME_STATE.scene.mousereleased(x, y, button)
end

function love.mousemoved(x, y, dx, dy)
	if dy ~= 0 or dx ~= 0 then
		GAME_STATE.scene.mousemoved(x, y, dx, dy)
	end
end

function love.update(dt)
	if GAME_STATE.pause then
		return
	end
	GAME_STATE.scene.update(dt)
end

function love.draw()
	love.graphics.setColor(1, 1, 1, 1)
	GAME_STATE.scene.draw()
	GAME_STATE.scene.drawUI()
	if GAME_STATE.debug then
		love.graphics.setColor(1, 0, 0)
		love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
	end
end

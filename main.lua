love.graphics.setDefaultFilter("nearest", "nearest")

local Throw = require("scenes.throw")
local Store = require("scenes.store")
local canvas = love.graphics.newCanvas(1280, 720)

GAME_WIDTH = 1280
GAME_HEIGHT = 720

function love.load()
	love.physics.setMeter(64)
	GAME_STATE = {
		scene = nil,
		pause = false,
		debug = false,
		hand_strength = 3,
		mines_level = 0,
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
	if key == "f" then
		love.window.setFullscreen(not love.window.getFullscreen())
	end
	if key == "s" then
		GAME_STATE.scene.destroy()
		GAME_STATE.scene = Store()
	end
	if key == "escape" then
		love.event.quit()
	end
	GAME_STATE.scene.keypressed(key)
end

function love.mousepressed(windowX, windowY, button)
	local window_width, window_height = love.graphics.getDimensions()
	local window_aspect = window_width / window_height
	local game_aspect = GAME_WIDTH / GAME_HEIGHT
	local scale = window_aspect > game_aspect and window_height / GAME_HEIGHT
		or window_width / GAME_WIDTH
	local offsetX = (window_width - GAME_WIDTH * scale) / 2
	local offsetY = (window_height - GAME_HEIGHT * scale) / 2
	local x = (windowX - offsetX) / scale
	local y = (windowY - offsetY) / scale

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
	love.graphics.setCanvas(canvas)
	love.graphics.setColor(1, 1, 1, 1)
	GAME_STATE.scene.draw()
	GAME_STATE.scene.drawUI()
	if GAME_STATE.debug then
		love.graphics.setColor(1, 0, 0)
		love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
	end
	love.graphics.setCanvas()

	-- Draw the canvas to the screen maintaining aspect ratio
	local window_width, window_height = love.graphics.getDimensions()
	local window_aspect = window_width / window_height
	local game_aspect = GAME_WIDTH / GAME_HEIGHT
	local scale = window_aspect > game_aspect and window_height / GAME_HEIGHT
		or window_width / GAME_WIDTH
	local x = (window_width - GAME_WIDTH * scale) / 2
	local y = (window_height - GAME_HEIGHT * scale) / 2
	love.graphics.draw(canvas, x, y, 0, scale, scale)
end

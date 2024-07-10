love.graphics.setDefaultFilter("nearest", "nearest")

local Camera = require("lib.camera")
local Floor = require("lib.floor")

local camera
local floor

function love.load()
  camera = Camera()
  floor = Floor()
  camera.scale = 5
end

function love.update(dt)
  if love.keyboard.isDown("up") then
    camera:move(0, -100 * dt)
  end
  if love.keyboard.isDown("down") then
    camera:move(0, 100 * dt)
  end
  if love.keyboard.isDown("left") then
    camera:move(-100 * dt, 0)
  end
  if love.keyboard.isDown("right") then
    camera:move(100 * dt, 0)
  end
end

function love.draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.clear(0.53, 0.81, 0.92)
  camera:draw(function()
    floor:draw(camera)
  end)
end

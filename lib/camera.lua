local Camera = function()
  local camera = {}
  camera.x = 0
  camera.y = 0
  camera.scale = 1
  camera.rotation = 0

  function camera:draw(func)
    love.graphics.push()
    love.graphics.translate(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
    love.graphics.scale(self.scale)
    love.graphics.rotate(self.rotation)
    love.graphics.translate(-self.x, -self.y)
    func()
    love.graphics.pop()
  end

  function camera:move(x, y)
    self.x = self.x + x
    self.y = self.y + y
  end

  function camera:moveTo(x, y)
    self.x = x
    self.y = y
  end

  function camera:getViewportWidth()
    return love.graphics.getWidth() / self.scale
  end

  function camera:getViewportHeight()
    return love.graphics.getHeight() / self.scale
  end

  return camera
end

return Camera

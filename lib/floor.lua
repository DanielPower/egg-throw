local assets = require("assets")

local function Floor()
  local floor = {}
  local texture = assets.textures.grass
  local quad = assets.quads.grass.grass2
  local width = assets.quads.grass.width

  function floor:draw(camera)
    local offsetX = camera.x
    local viewportWidth = camera:getViewportWidth()
    for i = math.floor(offsetX / width), math.floor((offsetX + viewportWidth) / width) do
      love.graphics.draw(texture, quad, -viewportWidth / 2 + i * width, 0)
    end
  end

  return floor
end

return Floor

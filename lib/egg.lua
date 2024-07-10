local assets = require("assets")
local Egg = function()
	local egg = {}
	egg.x = 0
	egg.y = 0

	function egg:update(dt)
		self.y = self.y + 100 * dt
	end

	function egg:draw()
		love.graphics.draw(assets.textures.egg, self.x, self.y)
	end

	return egg
end

return Egg

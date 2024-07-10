local Camera = function()
	local camera = {}
	camera.x = 0
	camera.y = 0
	camera.scale = 1
	camera.rotation = 0

	function camera:update(dt)
		if love.keyboard.isDown("up") then
			self:move(0, -100 * dt)
		end
		if love.keyboard.isDown("down") then
			self:move(0, 100 * dt)
		end
		if love.keyboard.isDown("left") then
			self:move(-100 * dt, 0)
		end
		if love.keyboard.isDown("right") then
			self:move(100 * dt, 0)
		end
		if love.keyboard.isDown("-") then
			self.scale = camera.scale * 0.5 ^ dt
		end
		if love.keyboard.isDown("=") then
			self.scale = camera.scale * 2 ^ dt
		end
	end

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

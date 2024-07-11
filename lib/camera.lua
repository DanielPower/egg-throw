local Camera = function(opt)
	local camera = {}
	camera.x = opt.x or 0
	camera.y = opt.y or 0
	camera.scale = opt.scale or 1
	camera.angle = opt.angle or 0
	camera.target = opt.target or nil

	function camera:update(dt)
		if camera.target then
			camera:moveTo(camera.target.body:getX(), camera.target.body:getY())
		else
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
		love.graphics.rotate(self.angle)
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

	function camera:toWorld(x, y)
		return (x - love.graphics.getWidth() / 2) / self.scale + self.x,
			(y - love.graphics.getHeight() / 2) / self.scale + self.y
	end

	function camera:toScreen(x, y)
		return (x - self.x) * self.scale + love.graphics.getWidth() / 2,
			(y - self.y) * self.scale + love.graphics.getHeight() / 2
	end

	function camera:getViewportWidth()
		return love.graphics.getWidth() / self.scale
	end

	function camera:getViewportHeight()
		return love.graphics.getHeight() / self.scale
	end

	function camera:getMousePosition()
		return camera:toWorld(love.mouse.getX(), love.mouse.getY())
	end

	return camera
end

return Camera

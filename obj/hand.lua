local handImage = love.graphics.newImage("assets/madness.png")
local openHandQuad = love.graphics.newQuad(644, 247, 76, 89, handImage:getDimensions())
local closedHandQuad = love.graphics.newQuad(419, 281, 72, 74, handImage:getDimensions())

local Hand = function(scene)
	local hand = {}
	local joint = nil

	function hand:update()
		if joint then
			joint:setTarget(scene.context.camera:getMousePosition())
		end
	end

	function hand:mousepressed(event)
		local wx, wy = scene.context.camera:toWorld(event.x, event.y)
		if event.handled then
			return
		end
		local bodies = scene.context.world:getBodies()
		for _, body in ipairs(bodies) do
			local userData = body:getUserData()
			if userData and userData.egg then
				local fixtures = body:getFixtures()
				for _, fixture in ipairs(fixtures) do
					if fixture:testPoint(wx, wy) then
						joint = love.physics.newMouseJoint(body, wx, wy)
						break
					end
				end
			end
		end
	end

	function hand:mousereleased()
		if joint then
			joint:destroy()
			joint = nil
		end
	end

	function hand:draw()
		if joint then
			local x1, y1, x2, y2 = joint:getAnchors()
			love.graphics.setColor(1, 0, 0)
			love.graphics.line(x1, y1, x2, y2)
			love.graphics.setColor(1, 1, 1)
		end
	end

	function hand:drawUI()
		local x, y = love.mouse.getPosition()
		if joint then
			love.graphics.draw(handImage, closedHandQuad, x, y, 0, 1, 1, 36, 37)
		else
			love.graphics.draw(handImage, openHandQuad, x, y, math.pi / 2, 1, 1, 38, 45)
		end
	end

	function hand:destroy()
		if joint then
			joint:destroy()
		end
	end

	return hand
end

return Hand

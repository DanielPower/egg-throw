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
			if userData and userData.tags and userData.tags.egg then
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

	function hand:destroy()
		if joint then
			joint:destroy()
		end
	end

	return hand
end

return Hand

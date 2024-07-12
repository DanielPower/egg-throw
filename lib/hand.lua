local Hand = function(scene)
	local hand = {}

	local body = love.physics.newBody(scene.context.world, 0, 0, "dynamic")
	local mouseJoint = love.physics.newMouseJoint(body, 0, 0)
	local joint = nil
	body:setUserData({ entity = hand })

	function hand:update(dt)
		mouseJoint:setTarget(scene.context.camera:getMousePosition())
	end

	function hand:mousepressed(event)
		local wx, wy = scene.context.camera:toWorld(event.x, event.y)
		if event.handled then
			return
		end
		local bodies = scene.context.world:getBodies()
		for _, otherBody in ipairs(bodies) do
			local userData = otherBody:getUserData()
			if userData and userData.tags and userData.tags.egg then
				local fixtures = otherBody:getFixtures()
				for _, fixture in ipairs(fixtures) do
					if fixture:testPoint(wx, wy) then
						joint = love.physics.newDistanceJoint(body, otherBody, wx, wy, wx, wy)
						break
					end
				end
			end
		end
	end

	function hand:mousereleased(event)
		if joint then
			joint:destroy()
			joint = nil
		end
	end

	return hand
end

return Hand

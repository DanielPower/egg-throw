local Hand = function(scene)
	local hand = {}
	local grab = nil

	local function advanceStage()
		scene.context.stage = "throw"
		scene.context.camera.target = function()
			local x, y = scene.context.egg.body:getPosition()
			return x, y - 100
		end
		scene.destroyEntity(hand)
	end

	function hand:update(dt)
		if grab then
			grab.joint:setTarget(scene.context.camera:getMousePosition())
			local x, y = grab.joinedBody:getPosition()
			if not scene.context.camera:inViewport(x, y) then
				advanceStage()
			end
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
						grab = {
							joint = love.physics.newMouseJoint(body, wx, wy),
							joinedBody = body,
						}
						grab.joint:setMaxForce(1000)
						break
					end
				end
			end
		end
	end

	function hand:mousereleased()
		if grab then
			advanceStage()
		end
	end

	function hand:draw()
		if grab then
			local x1, y1, x2, y2 = grab.joint:getAnchors()
			love.graphics.setColor(1, 0, 0)
			love.graphics.line(x1, y1, x2, y2)
			love.graphics.setColor(1, 1, 1)
		end
	end

	function hand:destroy()
		if grab then
			grab.joint:destroy()
		end
	end

	return hand
end

return Hand

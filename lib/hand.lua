local physics = require("lib.physics")

local Hand = function(scene, opt)
	local hand = {}

	local body = love.physics.newBody(scene.context.world, 0, 0, "static")
	body:setUserData({ entity = hand })

	function hand:update(dt)
		body:setPosition(scene.context.camera:getMousePosition())
	end

	function hand:mousepressed(event)
		local wx, wy = scene.context.camera:toWorld(event.x, event.y)
		if event.handled then
			return
		end
		local bodies = scene.context.world:getBodies()
		print("click")
		for _, otherBody in ipairs(bodies) do
			local userData = otherBody:getUserData()
			if userData and userData.tags and userData.tags.egg then
				local fixtures = otherBody:getFixtureList()
				for _, fixture in ipairs(fixtures) do
					if fixture:testPoint(wx, wy) then
						scene.destroyEntity(userData.entity)
					end
				end
			end
		end
	end

	return hand
end

return Hand

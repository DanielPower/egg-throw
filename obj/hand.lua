local inspect = require("lib/inspect")
local handImage = love.graphics.newImage("assets/madness.png")
local openHandQuad = love.graphics.newQuad(644, 247, 76, 89, handImage:getDimensions())
local closedHandQuad = love.graphics.newQuad(419, 281, 72, 74, handImage:getDimensions())

local Hand = function(scene)
	local hand = {}
	local joint = nil
	local dx, dy = 0, 0
	local handBody = love.physics.newBody(scene.context.world, 0, 0, "dynamic")
	handBody:setMass(10)
	handBody:setGravityScale(0)
	handBody:setInertia(0)
	local handJoint = love.physics.newMouseJoint(handBody, 0, 0)
	handJoint:setMaxForce(5000 * 1.25 ^ GAME_STATE.hand_strength)
	love.mouse.setRelativeMode(true)
	love.mouse.setGrabbed(true)

	function hand:mousemoved(event)
		dx, dy = event.dx, event.dy
	end

	function hand:mousepressed(event)
		local x, y = handBody:getPosition()
		if event.handled then
			return
		end
		local bodies = scene.context.world:getBodies()
		for _, body in ipairs(bodies) do
			local userData = body:getUserData()
			if userData and userData.egg then
				local fixtures = body:getFixtures()
				for _, fixture in ipairs(fixtures) do
					if fixture:testPoint(x, y) then
						joint = love.physics.newRevoluteJoint(handBody, body, x, y, x, y, false)
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

	function hand:update(dt)
		local x, y = handBody:getPosition()
		handJoint:setTarget(x + dx, y + dy)
		dx, dy = 0, 0
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
		local x, y = scene.context.camera:toScreen(handBody:getPosition())
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
		love.mouse.setRelativeMode(false)
		love.mouse.setGrabbed(false)
	end

	return hand
end

return Hand

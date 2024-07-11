local Hand = function(scene, opt)
	local hand = {}

	hand.body = love.physics.newBody(opt.world, opt.x, opt.y, "static")

	function hand:update(dt)
		hand.body:setPosition(scene.context.camera:getMousePosition())
	end

	return hand
end

return Hand

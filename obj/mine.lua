local anim8 = require("lib/anim8")

local bomb = love.graphics.newImage("assets/bomb/bomb.png")
local bombGrid = anim8.newGrid(64, 64, bomb:getWidth(), bomb:getHeight())
local idleAnimation = anim8.newAnimation(bombGrid("1-2", 1), 0.1)
local explodeAnimation = anim8.newAnimation(bombGrid("11-12", 1), 0.1)

local Mine = function(scene, opt)
	local mine = {}
	local body = love.physics.newBody(scene.context.world, opt.x, opt.y, "dynamic")
	love.physics.newFixture(body, love.physics.newCircleShape(24), 1)
	local animation = idleAnimation
	local explodeTimer = nil

	function mine:update(dt)
		animation:update(dt)
		print("update")
		print(explodeTimer)

		local contacts = body:getContacts()
		for _, contact in pairs(contacts) do
			if not contact:isTouching() then
				break
			end
			for _, fixture in pairs({ contact:getFixtures() }) do
				local contactBody = fixture:getBody()
				local userData = contactBody:getUserData()
				if userData and userData.tags.egg and explodeTimer == nil then
					animation = explodeAnimation
					explodeTimer = 0.2
				end
			end
		end

		if explodeTimer then
			explodeTimer = explodeTimer - dt
			if explodeTimer <= 0 then
				scene.context.egg.body:applyLinearImpulse(0, -500)
				scene.destroyEntity(mine)
			end
		end
	end

	function mine:draw()
		local x, y = body:getPosition()
		animation:draw(bomb, x, y, body:getAngle(), 1, 1, 32, 24)
	end

	function mine:destroy()
		body:destroy()
	end

	return mine
end

return Mine

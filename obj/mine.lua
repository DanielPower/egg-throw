local anim8 = require("lib/anim8")
local inspect = require("lib/inspect")

local bomb = love.graphics.newImage("assets/bomb/bomb.png")
local bombGrid = anim8.newGrid(64, 64, bomb:getWidth(), bomb:getHeight())
local idleAnimation = anim8.newAnimation(bombGrid("1-2", 1), 0.1)
local explodeAnimation = anim8.newAnimation(bombGrid("11-12", 1), 0.1)

local Mine = function(scene, opt)
	local mine = {}
	local body = love.physics.newBody(scene.context.world, opt.x, opt.y, "static")
	body:setUserData({ name = "b_mine", entity = mine })
	local fixture = love.physics.newFixture(body, love.physics.newCircleShape(24), 1)
	fixture:setUserData({ name = "f_mine", entity = mine, mine = true })
	fixture:setSensor(true)
	local animation = idleAnimation
	local explodeTimer = nil

	function mine:update(dt)
		animation:update(dt)

		if explodeTimer then
			explodeTimer = explodeTimer - dt
			if explodeTimer <= 0 then
				scene.destroyEntity(mine)
			end
		end
	end

	function mine:beginContact(otherFixture)
		local otherFixtureUserData = otherFixture:getUserData()
		if explodeTimer == nil and otherFixtureUserData and otherFixtureUserData.egg then
			local vx, vy = scene.context.egg.body:getLinearVelocity()
			scene.context.egg.body:setLinearVelocity(vx, -vy)
			scene.context.egg.body:applyLinearImpulse(1000, -5000)
			scene.context.egg.body:applyAngularImpulse(1000)
			animation = explodeAnimation
			explodeTimer = 0.2
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

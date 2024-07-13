local anim8 = require("lib/anim8")
local inspect = require("lib/inspect")

local bomb = love.graphics.newImage("assets/bomb/bomb.png")
local bombGrid = anim8.newGrid(64, 64, bomb:getWidth(), bomb:getHeight())
local idleAnimation = anim8.newAnimation(bombGrid("1-2", 1), 0.1)
local explodeAnimation = anim8.newAnimation(bombGrid("11-12", 1), 0.1)

local Mine = function(scene, opt)
	local mine = {}
	local body = love.physics.newBody(scene.context.world, opt.x, opt.y, "dynamic")
	body:setUserData({ name = "b_mine", entity = mine })
	local fixture = love.physics.newFixture(body, love.physics.newCircleShape(24), 1)
	fixture:setUserData({ name = "f_mine", entity = mine, mine = true })
	local animation = idleAnimation
	local explodeTimer = nil

	function mine:update(dt)
		animation:update(dt)

		if explodeTimer then
			explodeTimer = explodeTimer - dt
			if explodeTimer <= 0 then
				scene.context.egg.body:applyLinearImpulse(0, -500)
				scene.destroyEntity(mine)
			end
		end
	end

	function mine:beginContact(otherFixture)
		local otherFixtureUserData = otherFixture:getUserData()
		print("beginContact", inspect(otherFixture:getUserData()))
		if otherFixtureUserData and otherFixtureUserData.name then
			print(otherFixtureUserData.name)
		end
		if explodeTimer == nil and otherFixtureUserData and otherFixtureUserData.egg then
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

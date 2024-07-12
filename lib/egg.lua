local assets = require("assets")
local geometry = require("lib.geometry")

local FRICTION = 0.7
local RESTITUTION = 0.5

local Egg = function(scene, opt)
	local egg = {}
	egg.body = love.physics.newBody(scene.context.world, opt.x, opt.y, "dynamic")
	egg.body:setUserData({ entity = egg, tags = { egg = true } })

	local x1, y1, r1 = 1, -12, 16
	local x2, y2, r2 = 0, 8, 24
	local upperBall = love.physics.newCircleShape(x1, y1, r1)
	local lowerBall = love.physics.newCircleShape(x2, y2, r2)
	local midSection =
		love.physics.newPolygonShape(geometry.external_tangents(x1, y1, r1, x2, y2, r2))
	local f1 = love.physics.newFixture(egg.body, upperBall)
	local f2 = love.physics.newFixture(egg.body, lowerBall)
	local f3 = love.physics.newFixture(egg.body, midSection)
	f1:setFriction(FRICTION)
	f2:setFriction(FRICTION)
	f3:setFriction(FRICTION)
	f1:setRestitution(RESTITUTION)
	f2:setRestitution(RESTITUTION)
	f3:setRestitution(RESTITUTION)

	local texture = assets.textures.egg[math.random(#assets.textures.egg)]
	local offsetX = texture:getWidth() / 2
	local offsetY = texture:getHeight() / 2

	function egg:draw()
		love.graphics.draw(
			texture,
			egg.body:getX(),
			egg.body:getY(),
			egg.body:getAngle(),
			1,
			1,
			offsetX,
			offsetY
		)
	end

	function egg:destroy()
		egg.body:destroy()
	end

	return egg
end

return Egg

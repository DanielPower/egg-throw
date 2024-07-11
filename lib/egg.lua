local assets = require("assets")
local geometry = require("lib.geometry")
local physics = require("lib.physics")

local FRICTION = 0.7
local RESTITUTION = 0.5

local Egg = function(opt)
	local egg = {}

	egg.body = love.physics.newBody(opt.world, opt.x, opt.y, "dynamic")
	local x1, y1, r1 = 0, -12, 16
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

	function egg:mousepressed(event)
		if event.handled then
			return
		end
		if physics.pointInBody(event.wx, event.wx, egg.body) then
			event.handled = true
		end
	end

	function egg:draw()
		love.graphics.draw(
			texture,
			self.body:getX(),
			self.body:getY(),
			self.body:getAngle(),
			1,
			1,
			offsetX,
			offsetY
		)
	end

	return egg
end

return Egg

local assets = require("assets")
local geometry = require("lib.geometry")

local Egg = function(opt)
	local egg = {}

	local body = love.physics.newBody(opt.world, opt.x, opt.y, "dynamic")
	local x1, y1, r1 = 0, -12, 16
	local x2, y2, r2 = 0, 8, 24
	local upperBall = love.physics.newCircleShape(x1, y1, r1)
	local lowerBall = love.physics.newCircleShape(x2, y2, r2)
	local midSection =
		love.physics.newPolygonShape(geometry.external_tangents(x1, y1, r1, x2, y2, r2))
	love.physics.newFixture(body, upperBall)
	love.physics.newFixture(body, lowerBall)
	love.physics.newFixture(body, midSection)

	local texture = assets.textures.egg
	local offsetX = texture:getWidth() / 2
	local offsetY = texture:getHeight() / 2

	function egg:draw()
		love.graphics.draw(
			texture,
			body:getX(),
			body:getY(),
			body:getAngle(),
			1,
			1,
			offsetX,
			offsetY
		)
	end

	return egg
end

return Egg

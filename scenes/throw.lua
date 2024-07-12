local physics = require("lib.physics")
local Scene = require("lib.scene")
local Floor = require("lib.floor")
local Hand = require("lib.hand")
local Egg = require("lib.egg")
local Camera = require("lib.camera")

local Throw = function()
	local throw = Scene({
		context = {
			world = love.physics.newWorld(0, 9.81 * 64, true),
			camera = Camera({ y = -160, scale = 2 }),
		},
		preUpdate = function(scene, dt)
			scene.context.world:update(dt)
		end,
		postUpdate = function(scene, dt)
			scene.context.camera:update(dt)
		end,
		preDraw = function(scene)
			love.graphics.clear(0.53, 0.81, 0.92)
			scene.context.camera:attach()
		end,
		postDraw = function(scene)
			physics.debugDraw(scene.context.world)
			scene.context.camera:detach()
		end,
	})

	throw.createEntity(Hand)
	throw.createEntity(Egg, { x = 0, y = -100 })
	throw.createEntity(Floor)

	return throw
end

return Throw

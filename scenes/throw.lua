local physics = require("lib.physics")
local Scene = require("lib.scene")
local Floor = require("lib.floor")
local Hand = require("lib.hand")
local Egg = require("lib.egg")
local Camera = require("lib.camera")

local Throw = function()
	local throw = Scene({
		initialize = function(scene)
			scene.context.world = love.physics.newWorld(0, 9.81 * 64, true)
			scene.context.camera = Camera({ y = -160, scale = 2 })
			scene.context.stage = "pre-throw"

			scene.createEntity(Hand)
			scene.createEntity(Floor)
			scene.context.egg = scene.createEntity(Egg, { x = 0, y = -100 })
		end,
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
			if scene.context.stage == "throw" then
				love.graphics.setColor(1, 0, 0)
				love.graphics.setFont(love.graphics.newFont(30))
				love.graphics.print("Distance: " .. math.floor(scene.context.camera.x), 10, 10)
			end
		end,
	})

	return throw
end

return Throw

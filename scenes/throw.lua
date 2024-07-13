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
			if scene.context.stage == "pre-throw" then
				if not scene.context.camera:inViewport(scene.context.egg.body:getPosition()) then
					print("inViewport")
					scene.context.stage = "throw"
					scene.context.camera.target = function()
						local x, y = scene.context.egg.body:getPosition()
						return x, y - 100
					end
				end
			end
		end,
		postUpdate = function(scene, dt)
			scene.context.camera:update(dt)
			if scene.context.stage == "throw" and not scene.context.egg.body:isAwake() then
				scene.context.stage = "done"
			end
		end,
		preDraw = function(scene)
			love.graphics.clear(0.53, 0.81, 0.92)
			scene.context.camera:attach()
		end,
		postDraw = function(scene)
			physics.debugDraw(scene.context.world)
			scene.context.camera:detach()
			love.graphics.setColor(1, 0, 0)
			love.graphics.setFont(love.graphics.newFont(30))
			if scene.context.stage == "pre-throw" then
				love.graphics.print("Click and drag the egg to throw it", 100, 100)
			end
			if scene.context.stage == "throw" or scene.context.stage == "done" then
				love.graphics.print(
					"Distance: " .. math.floor(scene.context.egg.body:getX()),
					10,
					10
				)
				if scene.context.stage == "done" then
					love.graphics.print("Press R to restart", 10, 40)
				end
			end
		end,
	})

	return throw
end

return Throw

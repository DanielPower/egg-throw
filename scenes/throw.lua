local physics = require("lib.physics")
local Scene = require("lib.scene")
local Camera = require("lib.camera")
local Floor = require("obj.floor")
local Hand = require("obj.hand")
local Egg = require("obj.egg")

local Throw = function()
	local throw = Scene({
		initialize = function(scene)
			scene.context.world = love.physics.newWorld(0, 9.81 * 64, true)
			scene.context.world:setCallbacks(function(a, b, contact)
				local aData = a:getUserData()
				local bData = b:getUserData()
				if aData and aData.entity and aData.entity.beginContact then
					aData.entity:beginContact(b, a, contact)
				end
				if bData and bData.entity and bData.entity.beginContact then
					bData.entity:beginContact(a, b, contact)
				end
			end, function(a, b, contact)
				local aData = a:getUserData()
				local bData = b:getUserData()
				if aData and aData.entity and aData.entity.endContact then
					aData.entity:endContact(b, a, contact)
				end
				if bData and bData.entity and bData.entity.endContact then
					bData.entity:endContact(a, b, contact)
				end
			end, function(a, b, contact)
				local aData = a:getUserData()
				local bData = b:getUserData()
				if aData and aData.entity and aData.entity.preSolve then
					aData.entity:preSolve(b, a, contact)
				end
				if bData and bData.entity and bData.entity.preSolve then
					bData.entity:preSolve(a, b, contact)
				end
			end, function(a, b, contact)
				local aData = a:getUserData()
				local bData = b:getUserData()
				if aData and aData.entity and aData.entity.postSolve then
					aData.entity:postSolve(b, a, contact)
				end
				if bData and bData.entity and bData.entity.postSolve then
					bData.entity:postSolve(a, b, contact)
				end
			end)
			scene.context.camera = Camera({ y = -160, scale = 2 })
			scene.context.stage = "pre-throw"

			scene.createEntity(Floor)
			scene.context.hand = scene.createEntity(Hand)
			scene.context.egg = scene.createEntity(Egg, { x = 0, y = -100 })
		end,
		preUpdate = function(scene, dt)
			scene.context.world:update(dt)
			if scene.context.stage == "pre-throw" then
				if not scene.context.camera:inViewport(scene.context.egg.body:getPosition()) then
					scene.destroyEntity(scene.context.hand)
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

local Scene = function(opt)
	local scene = {}
	scene.entities = {}
	scene.context = opt.context or {}
	scene.destroyList = {}

	function scene.keypressed(key)
		local event = { key = key, handled = false }
		if opt.preKeypressed then
			opt.preKeypressed(scene, event)
		end
		if opt.keypressed then
			opt.keypressed(scene, event)
		else
			for _, entity in ipairs(scene.entities) do
				if entity.keypressed then
					entity:keypressed(event)
				end
			end
		end
		if opt.postKeypressed then
			opt.postKeypressed(scene, event)
		end
	end

	function scene.mousepressed(x, y, button)
		local event = { x = x, y = y, button = button, handled = false }
		if opt.preMousepressed then
			opt.preMousepressed(scene, event)
		end
		if opt.mousepressed then
			opt.mousepressed(scene, event)
		else
			for _, entity in ipairs(scene.entities) do
				if entity.mousepressed then
					entity:mousepressed(event)
				end
			end
		end
		if opt.postMousepressed then
			opt.postMousepressed(scene, event)
		end
	end

	function scene.mousereleased(x, y, button)
		local event = { x = x, y = y, button = button, handled = false }
		if opt.preMousereleased then
			opt.preMousereleased(scene, event)
		end
		if opt.mousepressed then
			opt.mousepressed(scene, event)
		else
			for _, entity in ipairs(scene.entities) do
				if entity.mousereleased then
					entity:mousereleased(event)
				end
			end
		end
		if opt.postMousereleased then
			opt.postMousereleased(scene, event)
		end
	end

	function scene.update(dt)
		if opt.preUpdate then
			opt.preUpdate(scene, dt)
		end
		if opt.update then
			opt.update(scene, dt)
		else
			for _, entity in ipairs(scene.entities) do
				if entity.update then
					entity:update(scene, dt)
				end
			end
			for removedEntity in pairs(scene.destroyList) do
				if removedEntity.destroy then
					for i, entity in ipairs(scene.entities) do
						if entity == removedEntity then
							table.remove(scene.entities, i)
							break
						end
					end
					scene.destroyList[removedEntity] = nil
					removedEntity:destroy()
				end
			end
		end
		if opt.postUpdate then
			opt.postUpdate(scene, dt)
		end
	end

	function scene.draw()
		if opt.preDraw then
			opt.preDraw(scene)
		end
		if opt.draw then
			opt.draw(scene)
		else
			for _, entity in ipairs(scene.entities) do
				if entity.draw then
					entity:draw()
				end
			end
		end
		if opt.postDraw then
			opt.postDraw(scene)
		end
	end

	function scene.createEntity(constructor, entityOptions)
		local entity = constructor(scene, entityOptions or {})
		table.insert(scene.entities, entity)
	end

	function scene.destroyEntity(removedEntity)
		scene.destroyList[removedEntity] = true
	end

	return scene
end

return Scene

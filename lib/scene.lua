local Scene = function(opt)
	local scene = {}
	scene.entities = {}
	scene.context = {}
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

	function scene.mousemoved(x, y, dx, dy)
		local event = { x = x, y = y, dx = dx, dy = dy, handled = false }
		if opt.preMousemoved then
			opt.preMousemoved(scene, event)
		end
		if opt.mousemoved then
			opt.mousemoved(scene, event)
		else
			for _, entity in ipairs(scene.entities) do
				if entity.mousemoved then
					entity:mousemoved(event)
				end
			end
		end
		if opt.postMousemoved then
			opt.postMousemoved(scene, event)
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
					entity:update(dt)
				end
			end
			for removedEntity in pairs(scene.destroyList) do
				if removedEntity.destroy then
					removedEntity:destroy()
				end
				for i, entity in ipairs(scene.entities) do
					if entity == removedEntity then
						table.remove(scene.entities, i)
						break
					end
				end
				scene.destroyList[removedEntity] = nil
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

	function scene.drawUI()
		if opt.preDrawUI then
			opt.preDrawUI(scene)
		end
		if opt.drawUI then
			opt.drawUI(scene)
		else
			for _, entity in ipairs(scene.entities) do
				if entity.drawUI then
					entity:drawUI()
				end
			end
		end
		if opt.postDrawUI then
			opt.postDrawUI(scene)
		end
	end

	function scene.destroy()
		for _, entity in ipairs(scene.entities) do
			if entity.destroy then
				entity:destroy()
			end
		end
	end

	function scene.createEntity(constructor, entityOptions)
		local entity = constructor(scene, entityOptions or {})
		table.insert(scene.entities, entity)
		return entity
	end

	function scene.destroyEntity(removedEntity)
		scene.destroyList[removedEntity] = true
	end

	if opt.initialize then
		opt.initialize(scene)
	end

	return scene
end

return Scene

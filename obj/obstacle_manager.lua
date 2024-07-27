local Mine = require("obj.mine")

local ObstacleManager = function(scene)
	local obstacleManager = {}
	local nextMine = math.random(100, 1000 * (0.9 ^ GAME_STATE.mines_level))
	print(nextMine)

	function obstacleManager:update(dt)
		local eggX, _ = scene.context.egg.body:getPosition()
		if eggX > nextMine then
			scene.createEntity(Mine, { x = scene.context.camera.x + 800, y = -24 })
			nextMine = eggX + math.random(20, 1000 * (0.9 ^ GAME_STATE.mines_level))
			print(nextMine)
		end
	end

	return obstacleManager
end

return ObstacleManager

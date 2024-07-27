local Mine = require("obj.mine")

local ObstacleManager = function(scene)
	local obstacleManager = {}
	local nextMine = -1000

	function obstacleManager:update(dt)
		if GAME_STATE.mines_level == 0 then
			return
		end
		local screenEdge = scene.context.camera:toWorld(GAME_WIDTH, 0)
		local eggX = scene.context.egg.body:getPosition()
		if eggX > nextMine then
			scene.createEntity(Mine, { x = screenEdge + 100, y = -24 })
			nextMine = eggX
				+ math.random(
					100 / GAME_STATE.mines_level,
					100 * (1.1 ^ (eggX / (50 * GAME_STATE.mines_level)))
				)
		end
	end

	return obstacleManager
end

return ObstacleManager

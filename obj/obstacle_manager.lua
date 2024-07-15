local Mine = require("obj.mine")

local ObstacleManager = function(scene)
	local obstacleManager = {}

	scene.createEntity(Mine, { x = 60, y = -24 })

	return obstacleManager
end

return ObstacleManager

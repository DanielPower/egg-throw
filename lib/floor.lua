local assets = require("assets")

local function Floor(scene)
	local floor = {}
	local texture = assets.textures.grass
	local grassQuad = assets.quads.grass.grass2
	local dirtQuad = assets.quads.grass.grass7
	local width = assets.quads.grass.width

	local body = love.physics.newBody(scene.context.world, 0, 0, "static")
	local shape = love.physics.newEdgeShape(-1000, 0, 1000, 0)
	love.physics.newFixture(body, shape)

	function floor:draw()
		local offsetX = scene.context.camera.x
		local viewportWidth = scene.context.camera:getViewportWidth()
		for i = math.floor(offsetX / width), math.floor((offsetX + viewportWidth) / width) do
			love.graphics.draw(texture, grassQuad, -viewportWidth / 2 + i * width, 0)
			for j = 1, 50 do
				love.graphics.draw(texture, dirtQuad, -viewportWidth / 2 + i * width, j * width)
			end
		end
	end

	return floor
end

return Floor

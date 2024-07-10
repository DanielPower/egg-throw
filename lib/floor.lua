local assets = require("assets")

local function Floor(opt)
	local floor = {}
	local texture = assets.textures.grass
	local grassQuad = assets.quads.grass.grass2
	local dirtQuad = assets.quads.grass.grass7
	local width = assets.quads.grass.width

	local body = love.physics.newBody(opt.world, 0, 0, "static")
	local shape = love.physics.newEdgeShape(-1000, 0, 1000, 0)
	love.physics.newFixture(body, shape)

	function floor:draw(camera)
		local offsetX = camera.x
		local viewportWidth = camera:getViewportWidth()
		for i = math.floor(offsetX / width), math.floor((offsetX + viewportWidth) / width) do
			love.graphics.draw(texture, grassQuad, -viewportWidth / 2 + i * width, 0)
			for j = 1, 5 do
				love.graphics.draw(texture, dirtQuad, -viewportWidth / 2 + i * width, j * width)
			end
		end
	end

	return floor
end

return Floor

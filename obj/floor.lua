local assets = require("assets")

local function Floor(scene)
	local floor = {}
	local texture = assets.textures.grass
	local grassQuad = assets.quads.grass.grass2
	local dirtQuad = assets.quads.grass.grass7
	local width = assets.quads.grass.width
	local height = assets.quads.grass.height

	local body = love.physics.newBody(scene.context.world, 0, 0, "static")
	local shape = love.physics.newEdgeShape(-1000, 0, 1000, 0)
	love.physics.newFixture(body, shape)

	function floor:update(dt)
		body:setPosition(scene.context.camera.x, 0)
	end

	function floor:draw()
		local viewportWidth = scene.context.camera:getViewportWidth()
		local viewportHeight = scene.context.camera:getViewportHeight()
		local middle = math.floor(scene.context.camera.x - viewportWidth / 2)
		local offsetX = middle % width
		for i = 0, math.floor(viewportWidth / width) + 1 do
			local x = middle - offsetX + i * width
			love.graphics.draw(texture, grassQuad, x, 0)
			love.graphics.draw(texture, grassQuad, x, 0)
			for j = 1, math.floor(viewportHeight / height) + 1 do
				local y = j * height
				love.graphics.draw(texture, dirtQuad, x, y)
				love.graphics.draw(texture, dirtQuad, x, y)
			end
		end
	end

	return floor
end

return Floor

local textures = {}
local quads = {}

textures.background = love.graphics.newImage("assets/background.jpg")
textures.grass = love.graphics.newImage("assets/grass/grass.png")

textures.egg = {}
for _, file in ipairs(love.filesystem.getDirectoryItems("assets/egg")) do
	table.insert(textures.egg, love.graphics.newImage("assets/egg/" .. file))
end

local grass_names = {
	{ "grass1", "grass2", "grass3", "grass4", "grass5" },
	{ "grass6", "grass7", "grass8", "grass9", "grass10" },
	{ "grass11", "grass12", "grass13", "grass14", "grass15" },
}

quads.grass = {
	xOffset = 1,
	yOffset = 1,
	width = 16,
	height = 16,
	padding = 2,
}
for x = 1, 5 do
	for y = 1, 3 do
		quads.grass[grass_names[y][x]] = love.graphics.newQuad(
			(x - 1) * quads.grass.width + x * quads.grass.padding,
			(y - 1) * quads.grass.height + y * quads.grass.padding,
			quads.grass.width,
			quads.grass.height,
			textures.grass:getDimensions()
		)
	end
end

return { textures = textures, quads = quads }

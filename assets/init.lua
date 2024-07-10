local textures = {}
local quads = {}

textures.egg = love.graphics.newImage("assets/egg/Purple.png")
textures.background = love.graphics.newImage("assets/background.jpg")
textures.grass = love.graphics.newImage("assets/grass/grass.png")

local grass_names = {
	{ "grass1", "grass2", "grass3", "grass4", "grass5" },
	{ "grass6", "grass7", "grass8", "grass9", "grass10" },
	{ "grass11", "grass12", "grass13", "grass14", "grass15" },
}

quads.grass = {
	width = 16,
	height = 16,
	padding = 1,
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

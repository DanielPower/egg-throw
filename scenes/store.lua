local eggmartImage = love.graphics.newImage("assets/eggmart.png")
local Scene = require("lib.scene")
local Button = require("obj.button")

local Store = function()
	local store = Scene({
		initialize = function(scene)
			scene.context.buttons = {
				scene.createEntity(Button, {
					text = "Buy egg",
					x = love.graphics.getWidth() / 2 - 100,
					y = love.graphics.getHeight() / 2 + 50,
					onClick = function()
						print("clicked2")
						GAME_STATE.money = GAME_STATE.money - 1
					end,
				}),
			}
		end,
		preDraw = function()
			love.graphics.setColor(0.5, 0.5, 0.5)
			love.graphics.draw(
				eggmartImage,
				love.graphics.getWidth() / 2,
				love.graphics.getHeight() / 2,
				0,
				1,
				1,
				eggmartImage:getWidth() / 2,
				eggmartImage:getHeight() / 2
			)
		end,
		postDraw = function()
			love.graphics.setColor(1, 1, 1)
			love.graphics.print("Money: " .. GAME_STATE.money, 10, 300)
		end,
	})

	return store
end

return Store

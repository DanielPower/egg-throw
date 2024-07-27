local eggmartImage = love.graphics.newImage("assets/eggmart.png")
local Scene = require("lib.scene")
local Button = require("obj.button")

local function strengthPrice()
	return math.floor((1.5 ^ GAME_STATE.hand_strength))
end

local function minesPrice()
	return math.floor((5 * 1.25 ^ GAME_STATE.mines_level))
end

local Store = function()
	local store = Scene({
		initialize = function(scene)
			scene.context.buyStrengthButton = scene.createEntity(Button, {
				x = love.graphics.getWidth() / 2 - 100,
				y = love.graphics.getHeight() / 2 - 50,
				onClick = function()
					if GAME_STATE.money < strengthPrice() then
						return
					end
					GAME_STATE.money = GAME_STATE.money - strengthPrice()
					GAME_STATE.hand_strength = GAME_STATE.hand_strength + 1
				end,
			})
			scene.context.buyMinesButton = scene.createEntity(Button, {
				x = love.graphics.getWidth() / 2 - 100,
				y = love.graphics.getHeight() / 2 + 25,
				onClick = function()
					if GAME_STATE.money < minesPrice() then
						return
					end
					GAME_STATE.money = GAME_STATE.money - minesPrice()
					GAME_STATE.mines_level = GAME_STATE.mines_level + 1
				end,
			})
			scene.createEntity(Button, {
				x = love.graphics.getWidth() / 2 - 100,
				y = love.graphics.getHeight() / 2 + 100,
				onClick = function()
					GAME_STATE.scene = require("scenes.throw")()
				end,
				text = "Back to throwing",
			})
		end,
		preUpdate = function(scene, dt)
			scene.context.buyStrengthButton.text = "Upgrade Strength: $"
				.. tostring(strengthPrice())
			if GAME_STATE.mines_level == 0 then
				scene.context.buyMinesButton.text = "Mines: $" .. tostring(minesPrice())
			else
				scene.context.buyMinesButton.text = "More Mines: $" .. tostring(minesPrice())
			end
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
			love.graphics.print("Money: $" .. GAME_STATE.money, 10, 100)
			love.graphics.print("Strength: " .. GAME_STATE.hand_strength, 10, 130)
			love.graphics.print("Mines Level: " .. GAME_STATE.mines_level, 10, 160)
		end,
	})

	return store
end

return Store

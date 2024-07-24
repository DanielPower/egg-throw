local Button = function(scene, opt)
	local button = {}
	button.x = opt.x or 0
	button.y = opt.y or 0
	button.fillColor = opt.fillColor or { 1, 1, 1 }
	button.textColor = opt.textColor or { 0, 0, 0 }
	button.borderColor = opt.borderColor or { 0, 0, 0 }
	button.padding = opt.padding or 10
	button.text = opt.text or "Click me"
	button.onClick = opt.onClick or function(event) end

	local width
	local height

	function button:update()
		width = love.graphics.getFont():getWidth(button.text) + button.padding * 2
		height = love.graphics.getFont():getHeight() + button.padding * 2
	end

	function button:draw()
		love.graphics.setColor(button.fillColor)
		love.graphics.rectangle("fill", button.x, button.y, width, height)
		love.graphics.setColor(button.borderColor)
		love.graphics.rectangle("line", button.x, button.y, width, height)
		love.graphics.setColor(button.textColor)
		love.graphics.print(button.text, button.x + button.padding, button.y + button.padding)
	end

	function button:mousepressed(event)
		if
			event.button == 1
			and event.x >= button.x
			and event.x <= button.x + width
			and event.y >= button.y
			and event.y <= button.y + height
		then
			print("clicked")
			button.onClick(event)
		end
	end

	return button
end

return Button

local Button = function(scene, opt)
	local button = {}
	local x = opt.x or 0
	local y = opt.y or 0
	local fillColor = opt.fillColor or { 1, 1, 1 }
	local textColor = opt.textColor or { 0, 0, 0 }
	local borderColor = opt.borderColor or { 0, 0, 0 }
	local padding = opt.padding or 10
	local text = opt.text or "Click me"
	local onClick = opt.onClick or function(event) end
	print(opt.onClick)

	local width = love.graphics.getFont():getWidth(text) + padding * 2
	local height = love.graphics.getFont():getHeight() + padding * 2

	function button:draw()
		love.graphics.setColor(fillColor)
		love.graphics.rectangle("fill", x, y, width, height)
		love.graphics.setColor(borderColor)
		love.graphics.rectangle("line", x, y, width, height)
		love.graphics.setColor(textColor)
		love.graphics.print(text, x + padding, y + padding)
	end

	function button:mousepressed(event)
		if
			event.button == 1
			and event.x >= x
			and event.x <= x + width
			and event.y >= y
			and event.y <= y + height
		then
			print("clicked")
			onClick(event)
		end
	end

	return button
end

return Button

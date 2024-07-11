local physics = {}

function physics.debugDraw(world)
	love.graphics.push()
	love.graphics.setColor(0, 1, 0)
	for _, body in ipairs(world:getBodies()) do
		love.graphics.push()
		love.graphics.translate(body:getX(), body:getY())
		love.graphics.rotate(body:getAngle())
		for _, fixture in ipairs(body:getFixtures()) do
			local shape = fixture:getShape()
			local shapeType = shape:getType()
			if shapeType == "circle" then
				local ox, oy = shape:getPoint()
				love.graphics.circle("line", ox, oy, shape:getRadius())
			elseif shapeType == "polygon" then
				love.graphics.polygon("line", shape:getPoints())
			elseif shapeType == "edge" then
				love.graphics.line(shape:getPoints())
			end
		end
		love.graphics.pop()
	end
	love.graphics.pop()
end

function physics.pointInBody(x, y, body)
	for _, fixture in ipairs(body:getFixtures()) do
		if fixture:testPoint(x, y) then
			return true
		end
	end
	return false
end

return physics

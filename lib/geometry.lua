local geometry = {}

-- Function to calculate the distance between the centers
function geometry.distance(x1, y1, x2, y2)
	return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end

-- Function to calculate the external tangents
function geometry.external_tangents(x1, y1, r1, x2, y2, r2)
	local d = geometry.distance(x1, y1, x2, y2)
	local alpha = math.atan2(y2 - y1, x2 - x1)
	local theta = math.acos((r1 - r2) / d)

	local phi1 = alpha + theta
	local phi2 = alpha - theta

	-- Points of tangency on Circle 1
	local x1t1 = x1 + r1 * math.cos(phi1)
	local y1t1 = y1 + r1 * math.sin(phi1)
	local x1t2 = x1 + r1 * math.cos(phi2)
	local y1t2 = y1 + r1 * math.sin(phi2)

	-- Points of tangency on Circle 2
	local x2t1 = x2 + r2 * math.cos(phi1)
	local y2t1 = y2 + r2 * math.sin(phi1)
	local x2t2 = x2 + r2 * math.cos(phi2)
	local y2t2 = y2 + r2 * math.sin(phi2)

	return x1t1, y1t1, x1t2, y1t2, x2t1, y2t1, x2t2, y2t2
end

return geometry

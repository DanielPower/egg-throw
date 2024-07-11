local function notNil(...)
	local argv = { ... }
	for i = 1, #argv do
		if argv[i] == nil then
			error("Expected non-nil value at argument " .. i)
		end
	end
	return ...
end

return notNil

function contains(list, x)
	for _, v in ipairs(list) do
		if v == x then return true end
	end
	return false
end
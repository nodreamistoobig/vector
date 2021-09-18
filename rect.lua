Rect = {}
Rect.__index = Rect

function Rect:create(x, y, w, h)
	local rect = {}
	setmetatable(rect, Rect)
	rect.x = x
	rect.y = y
	rect.w = w
	rect.h = h
	return rect
end


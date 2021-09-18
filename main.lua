require("vector")
require("mover")
require("rect")

function love.load()
	love.window.setTitle("Vector")
	width = love.graphics.getWidth()
	height = love.graphics.getHeight()
	love.graphics.setBackgroundColor(128/255, 128/255, 128/255)

	location = Vector:create(width*0.25, 0)
	velocity = Vector:create(0, 0)
	mover = Mover:create(location, velocity)
	mover2 = Mover:create(location*3, velocity)

	wind = Vector:create(0.01, 0)
	isWind = false
	gravity = Vector:create(0, 0.01)
	isGravity = false
	floating = Vector:create(0, -0.02)
	isFloationg = false

	rect1 = Rect:create(width*0.1, height*0.25, width*0.3, height/3)
	rect2 = Rect:create(width*0.6, height*0.25, width*0.3, height/3)
end

function love.draw()
	local r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(0, 190/255, 190/255, 0.5)
	love.graphics.rectangle("fill", rect1.x, rect1.y, rect1.w, rect1.h)
	love.graphics.rectangle("fill", rect2.x, rect2.y, rect2.w, rect2.h)
	love.graphics.setColor(r, g, b, a)
	mover:draw()
	mover2:draw()
	love.graphics.print("w: " .. tostring(isWind) .. " g: " .. tostring(isGravity) .. " f: " .. tostring(isFloationg))
	love.graphics.print(tostring(mover.velocity), tostring(mover.location.x + 20), tostring(mover.location.y))
	love.graphics.print(tostring(mover2.velocity), tostring(mover2.location.x + 20), tostring(mover2.location.y))
end

function love.update()
	mover:applyForce(gravity)
	mover2:applyForce(gravity)

	if (mover:belongsToRect(rect1)) then
		friction = (mover.velocity * -1):norm()
		if friction then
			friction:mul(0.01)
			mover:applyForce(friction)
		end
	end

	if (mover2:belongsToRect(rect2)) then
		friction = (mover.velocity):norm()
		if friction then
			friction:mul(0.01)
			mover2:applyForce(friction)
		end
	end

	mover:update()
	mover2:update()
	mover:checkBoundaries()
	mover2:checkBoundaries()
end

function love.keypressed(key)
	if key == 'g' then
		isGravity = not isGravity
	end
	if key == 'f' then
		isFloationg = not isFloationg
	end
	if key == 'w' then
		isWind = not isWind
		if isWind then
			wind = wind * -1
		end
	end
end

require("util")

snowflakes = {}
wind = {}

n = 3000
size = 1.5 	-- radius of flake
m = 0.00002 	-- mass of flake (in kg)
g = 9.81	-- gravitational acceleration (m/s)
offx = 50
offy = 50
slope = nil

love.load = function()
	width, height = love.graphics.getDimensions()

	wind.x = (love.math.random()*2 - 1)/2
	wind.y = love.math.random()/2

	slope = wind.y/wind.x

	if (wind.x==0) then wind.x = 0.0001 end
	if (wind.y==0) then wind.y = 0.0001 end

	for i=1, n do
		flake = {}
		flake.x = love.math.random(-offx, width+offx)
		flake.y = love.math.random(-offy, height+offy)
		flake.z = love.math.random()
		snowflakes[i] = {x=flake.x, y=flake.y, z=flake.z}
		--print (i, snowflakes[i].x, snowflakes[i].y, snowflakes[i].z)
		
	end
end

love.update = function(dt)
	for i=1, n do
		if inbound(snowflakes[i].x, snowflakes[i].y, -offx, width+offx, -offy, height+offy) then
			snowflakes[i].x = snowflakes[i].x + wind.x + (love.math.random()*2-1)/4
			snowflakes[i].y = snowflakes[i].y + m*g*snowflakes[i].z + wind.y*snowflakes[i].z
		else
			if love.math.random(1,2)==1 then
				snowflakes[i].x = love.math.random(-offx, width+offx)
				if love.math.random(1,2)==1 then
					snowflakes[i].y = love.math.random(-offy, 0)
				else
					snowflakes[i].y = love.math.random(height, height+offy)
				end
			else
				snowflakes[i].y = love.math.random(-offy, height+offy)
				if love.math.random(1,2)==1 then
					snowflakes[i].x = love.math.random(-offx, 0)
				else
					snowflakes[i].x = love.math.random(width, width+offx)
				end
			end
			snowflakes[i].z = love.math.random()
		end
	end
end

love.draw = function()
    	for i=1, n do
		if inbound(snowflakes[i].x, snowflakes[i].y, 0, width-1, 0, height-1) then
			--love.graphics.circle("fill", snowflakes[i].x, snowflakes[i].y,
			--			snowflakes[i].z*size)
			love.graphics.print('*', snowflakes[i].x, snowflakes[i].y, 0, snowflakes[i].z*size)
		end
    	end
end

love.quit = function()
	print("Have a snowy day!")
end

love.keypressed = function(key, code, isrepeat)
	if key == "q" then
		love.event.quit()
	end
end

love.mousemoved = function(x, y, dx, dy)
	wind.x = x*(1/width) - 0.5
end

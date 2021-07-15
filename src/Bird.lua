local globalData = require "src/globalData"

Bird = Class{}

function Bird:init()
	self.image = love.graphics.newImage('assets/bird.png')
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
	self.x = globalData.VIRTUAL_WIDTH / 2 - (self.width / 2)
	self.y = globalData.VIRTUAL_HEIGHT / 2 - (self.height / 2)
	self.dy = 0
end

function Bird:render()
	love.graphics.draw(self.image, self.x, self.y)
end

function Bird:update(dt)
	self.dy = self.dy + globalData.GRAVITY * dt
	self.y = self.y + self.dy
	if love.keyboard.wasPressed('space') then
		self.dy = globalData.JUMP
	end
	if self.y + self.height >= globalData.VIRTUAL_HEIGHT - globalData.GROUND_HEIGHT then
		self.y = globalData.VIRTUAL_HEIGHT - globalData.GROUND_HEIGHT - self.height
	end
end

function Bird:collides(pipe)
	if (self.x + 2) + (self.width - 4) >= pipe.x and self.x + 2 <= pipe.x + globalData.PIPE_WIDTH then
		if (self.y + 2) + (self.height - 4) >= pipe.y and self.y + 2 <= pipe.y + globalData.PIPE_HEIGHT then
			return true
		end
	end
	return false
end
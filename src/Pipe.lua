local globalData = require "src/globalData"

Pipe = Class{}

local PIPE_IMAGE = love.graphics.newImage('assets/pipe.png')
local PIPE_SCROLL = -60

function Pipe:init()
	self.x = globalData.VIRTUAL_WIDTH
	self.y = math.random( globalData.VIRTUAL_HEIGHT / 4, globalData.VIRTUAL_HEIGHT - 10  )
	self.width = PIPE_IMAGE:getWidth()
end

function Pipe:update(dt)
	self.x = self.x + PIPE_SCROLL * dt
end

function Pipe:render()
	love.graphics.draw(PIPE_IMAGE, self.x, self.y)
end
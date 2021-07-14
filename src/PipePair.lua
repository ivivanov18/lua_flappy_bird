require 'src/Pipe'
local globalData = require 'src/globalData'

PipePair = Class{}
local GAP_HEIGHT = 90

function PipePair:init(y)
	self.x = globalData.VIRTUAL_WIDTH + 32
	self.y = y

	self.pipes = {
		['upper'] = Pipe('top', self.y),
		['lower'] = Pipe('bottom', self.y + globalData.PIPE_HEIGHT + GAP_HEIGHT)
	}
	self.remove = false
end

function PipePair:update(dt)
	if self.x > -globalData.PIPE_WIDTH then
		self.x = self.x - globalData.PIPE_SPEED * dt
		self.pipes['upper'].x = self.x
		self.pipes['lower'].x = self.x
	else
		self.remove = true
	end
end

function PipePair:render()
	for k, pipe in pairs(self.pipes) do
		pipe:render()
	end
end
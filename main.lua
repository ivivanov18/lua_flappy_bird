push = require 'lib/push'
Class = require 'lib/class'
require 'src/Bird'
require 'src/Pipe'
require 'src/PipePair'

local globalData = require "src.globalData"

local background = love.graphics.newImage('assets/background.png')
local backgroundScroll = 0
local ground = love.graphics.newImage('assets/ground.png')
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60
local BACKGROUND_LOOPING_POINT = 413

local bird = Bird()
local pipePairs = {}
local spawnTimer = 0
local lastY = -globalData.PIPE_HEIGHT + math.random(80) + 20

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
	love.window.setTitle('Fifty Bird')
	push:setupScreen(globalData.VIRTUAL_WIDTH, globalData.VIRTUAL_HEIGHT, globalData.WINDOW_WIDTH, globalData.WINDOW_HEIGHT , {
		vsync = true, fullscreen = false, resizable = true
	})
	love.keyboard.keysPressed = {}
end

function love.update(dt)
	backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
	groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % globalData.VIRTUAL_WIDTH
	spawnTimer = spawnTimer + dt
	if spawnTimer > globalData.SPAWN_INTERVAL then
		local y = math.max(-globalData.PIPE_HEIGHT + 10, math.min(lastY + math.random(-20,20), globalData.VIRTUAL_HEIGHT - 90 - globalData.PIPE_HEIGHT))
		lastY = y
		table.insert(pipePairs, PipePair(y))
		spawnTimer = 0
	end
	bird:update(dt)
	for k, pair in pairs(pipePairs) do
		pair:update(dt)
		if pair.x < -globalData.PIPE_WIDTH then
			table.remove(pipePairs, k)
		end
	end
	love.keyboard.keysPressed = {}
end

function love.resize(w, h)
	push:resize(w, h)
end

function love.keypressed(key)
	love.keyboard.keysPressed[key] = true
	if key == 'escape' then
		love.event.quit()
	end
end

function love.keyboard.wasPressed(key)
	return love.keyboard.keysPressed[key]
end

function love.draw()
	push:start()
	love.graphics.draw(background, -backgroundScroll, 0)
	for k, pair in pairs(pipePairs) do
		pair:render()
	end
	love.graphics.draw(ground, -groundScroll, globalData.VIRTUAL_HEIGHT - globalData.GROUND_HEIGHT)
	bird:render()
	push:finish()
end
push = require 'lib/push'
Class = require 'lib/class'
require 'src/Bird'

local globalData = require "src.globalData"

local background = love.graphics.newImage('assets/background.png')
local backgroundScroll = 0
local ground = love.graphics.newImage('assets/ground.png')
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60
local BACKGROUND_LOOPING_POINT = 413

local bird = Bird()

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
	bird:update(dt)
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
	love.graphics.draw(ground, -groundScroll, globalData.VIRTUAL_HEIGHT - 16)
	bird:render()
	push:finish()
end
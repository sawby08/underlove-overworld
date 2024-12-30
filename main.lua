-- main.lua

local fpsLimiter = require 'lib.fpsLimiter'
local currentRoom

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    states = {
        overworld = require 'source.overworldState'
    }
    curState = states.overworld
    curState.load('test1')
end

function love.update(dt)
    curState.update(dt)
end

function love.draw()
    curState.draw()
end

function love.keypressed(key)
    if key == '1' then
        currentRoom = 'test1'
        curState.load('test1')
    end
    if key == '2' then
        currentRoom = 'snowdintest1'
        curState.load('snowdintest1')
    end
end
-- main.lua

require 'lib.fpsLimiter'

sti = require 'lib.sti'
wf = require 'lib.windfield'

Camera = require 'lib.camera'
camera = Camera()

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    states = {
        overworld = require 'source.overworldState'
    }
    curState = states.overworld
    curState.load()
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
        curState.load()
    end
    if key == '2' then
        currentRoom = 'snowdintest1'
        curState.load()
    end
end
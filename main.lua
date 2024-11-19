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
    love.graphics.push()
        love.graphics.setColor(0, 0, 0)
        love.graphics.print(collectgarbage("count"))
    love.graphics.pop()
end

function love.keypressed(key)
    if key == '1' then
        curState.load()
    end
end
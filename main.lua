-- main.lua

require 'lib.fpsLimiter'

sti = require 'lib.sti'
HC = require 'lib.hc'
wf = require 'lib.windfield'

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    states = {
        overworld = require 'source.overworldState'
    }
    curState = states.overworld
    curState.load()
end

function love.update(dt)
    deltaMultiplier = dt * 30
    curState.update(dt)
end

function love.draw()
    curState.draw()
end
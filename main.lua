-- main.lua

local backgroundMusic

require 'lib.fpsLimiter'

sti = require 'lib.sti'
wf = require 'lib.windfield'

Camera = require 'lib.camera'
camera = Camera()

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    backgroundMusic = love.audio.newSource("assets/sound/mus_ow1.ogg", "stream")

    states = {
        overworld = require 'source.overworldState'
    }
    curState = states.overworld
    curState.load()
end

function love.update(dt)
    backgroundMusic:play()
    curState.update(dt)
end

function love.draw()
    curState.draw()
end

function love.keypressed(key)
    if key == '1' then
        curState.load()
    end
end
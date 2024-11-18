-- overworld.lua

game = {}

function game.load()
    frisk = require 'source.obj.frisk'
    room = require 'source.obj.roomHandler'

    world = wf.newWorld(0, 0)

    frisk.load()
    room.load("assets/maps/test1.lua")
end

function game.update(dt)
    frisk.update(dt)
    room.update(dt)

    world:update(dt)
end

function game.draw()
    love.graphics.setColor(1, 1, 1)
    room.draw()
    frisk.draw()

    if love.keyboard.isDown("space") then
        world:draw(1, 0, 0)
    end
end

return game
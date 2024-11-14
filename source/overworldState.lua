-- overworld.lua

game = {}

function game.load()
    frisk = require 'source.obj.frisk'
    room = require 'source.obj.room'

    frisk.load()
    room.load("assets/maps/test1.lua")
end

function game.update(dt)
    frisk.update(dt)
    room.update(dt)
end

function game.draw()
    love.graphics.setColor(1, 1, 1)
    room.draw()
    frisk.draw(dt)

    love.graphics.setColor(0, 1, 0)
    frisk.collider:draw()
end

return game
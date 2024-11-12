-- overworld.lua

game = {}

function game.load()
    frisk = require 'source.obj.frisk'
    frisk.load()
end

function game.update(dt)
    frisk.update(dt)
end

function game.draw()
    frisk.draw(dt)
end

return game
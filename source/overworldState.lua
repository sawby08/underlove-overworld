-- overworld.lua

game = {}
local currentRoom = 'test1'

local function lockCamera()
    local x, y = camera:position()
    if x < 320 then x = 320 end
    if y < 240 then y = 240 end
    if x > map.tilewidth * map.width - 320 then x = map.tilewidth * map.width - 320 end
    if y > map.tileheight * map.height - 240 then y = map.tileheight * map.height - 240 end

    camera:lookAt(x, y)
end

local function unloadPackages()
    if frisk then
        package.loaded[frisk] = nil
    end
    if room then
        package.loaded[room] = nil
    end
    if world then
        world:destroy()
    end
end

function game.load()
    unloadPackages()
    frisk = require 'source.obj.frisk'
    room = require 'source.obj.roomHandler'

    world = wf.newWorld(0, 0)

    frisk.load()
    room.load("assets/maps/" .. currentRoom .. ".lua")
end

function game.update(dt)
    frisk.update(dt)
    room.update(dt)

    world:update(dt)

    camera:lookAt(math.floor(frisk.collider:getX()), math.floor(frisk.collider:getY()))
    lockCamera()
end

function game.draw()
    love.graphics.setColor(1, 1, 1)
    camera:attach()
        room.draw()
        frisk.draw()
        if love.keyboard.isDown('space') then world:draw(1, 0, 0) end
    camera:detach()
end

return game
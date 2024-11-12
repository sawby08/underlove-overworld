-- frisk.lua

frisk = {}

local friskSpritesheet
local x = 0
local y = 0
local frames = {}
local speed = 5


function frisk.load()
    friskSpritesheet = love.graphics.newImage("assets/images/frisk.png")
    
    frames = {
        up = {},
        down = {},
        right = {},
        left = {}
    }

    frames.down[1] = love.graphics.newQuad(0, 0, 20, 30, friskSpritesheet)
    frames.down[2] = love.graphics.newQuad(20, 0, 20, 30, friskSpritesheet)
    frames.down[3] = love.graphics.newQuad(40, 0, 20, 30, friskSpritesheet)
    frames.down[4] = love.graphics.newQuad(60, 0, 20, 30, friskSpritesheet)

end

function frisk.update(dt)
    if love.keyboard.isDown('left') then
        x = x - speed  * deltaMultiplier
    end
    if love.keyboard.isDown('up') then
        y = y - speed  * deltaMultiplier
    end
    if love.keyboard.isDown('down') then
        y = y + speed  * deltaMultiplier
    end
    if love.keyboard.isDown('right') then
        x = x + speed  * deltaMultiplier
    end
end

function frisk.draw()
    love.graphics.draw(friskSpritesheet, frames.down[1], x, y, 0, 2)
end


return frisk

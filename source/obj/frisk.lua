-- frisk.lua

frisk = {}

local friskSpritesheet
local speed = 5
local direction = 'down'
local canAnimate = false

local x = 320
local y = 240
local lastx, lasty = 0, 0
local vx, vy = 0, 0

local frames = {}
local curFrame = 1

local timeSince = 0

local colliderx, collidery = 0, 0


function frisk.load()
    friskSpritesheet = love.graphics.newImage("assets/images/frisk.png")
    
    frames = {
        up = {},
        down = {},
        right = {},
        left = {}
    }

    frames.up[1] = love.graphics.newQuad(240, 0, 20, 30, friskSpritesheet)
    frames.up[2] = love.graphics.newQuad(280, 0, 20, 30, friskSpritesheet)
    frames.up[3] = love.graphics.newQuad(260, 0, 20, 30, friskSpritesheet)
    frames.up[4] = love.graphics.newQuad(300, 0, 20, 30, friskSpritesheet)

    
    frames.down[1] = love.graphics.newQuad(0, 0, 20, 30, friskSpritesheet)
    frames.down[2] = love.graphics.newQuad(20, 0, 20, 30, friskSpritesheet)
    frames.down[3] = love.graphics.newQuad(40, 0, 20, 30, friskSpritesheet)
    frames.down[4] = love.graphics.newQuad(60, 0, 20, 30, friskSpritesheet)

    frames.left[1] = love.graphics.newQuad(80, 0, 20, 30, friskSpritesheet)
    frames.left[2] = love.graphics.newQuad(100, 0, 20, 30, friskSpritesheet)
    frames.left[3] = love.graphics.newQuad(120, 0, 20, 30, friskSpritesheet)
    frames.left[4] = love.graphics.newQuad(140, 0, 20, 30, friskSpritesheet)

    frames.right[1] = love.graphics.newQuad(180, 0, 20, 30, friskSpritesheet)
    frames.right[2] = love.graphics.newQuad(160, 0, 20, 30, friskSpritesheet)
    frames.right[3] = love.graphics.newQuad(200, 0, 20, 30, friskSpritesheet)
    frames.right[4] = love.graphics.newQuad(220, 0, 20, 30, friskSpritesheet)

    frisk.collider = world:newRectangleCollider(320, 240, 37, 30)
    frisk.collider:setFixedRotation(true)
end

function frisk.update(dt)
    lastx = colliderx
    lasty = collidery

    local vx = 0
    local vy = 0

    if love.keyboard.isDown('left') then
        vx = vx - speed*deltaMultiplier * 30
    end
    if love.keyboard.isDown('up') then
        vy = vx - speed*deltaMultiplier * 30
    end
    if love.keyboard.isDown('down') then
        vy = vy + speed*deltaMultiplier * 30
    end
    if love.keyboard.isDown('right') then
        vx = vx + speed*deltaMultiplier * 30
    end

    frisk.collider:setLinearVelocity(vx, vy)

    if vx > 0 then
        direction = 'right'
    elseif vx < 0 then
        direction = 'left'
    end

    if vy > 0 then
        direction = 'down'
    elseif vy < 0 then
        direction = 'up'
    end

    colliderx, collidery = frisk.collider:getX(), frisk.collider:getY()

    vx = colliderx - lastx
    vy = collidery - lasty

    if colliderx ~= lastx or collidery ~= lasty then
        canAnimate = true
    else
        canAnimate = false
    end

    if canAnimate then
        timeSince = timeSince + dt
        if timeSince > .2 then
            curFrame = curFrame + 1
            timeSince = 0
            if curFrame > 4 then
                curFrame = 1
            end
        end
    else
        curFrame = 1
    end
end

function frisk.draw()
    if direction == 'up' then
        love.graphics.draw(friskSpritesheet, frames.up[curFrame], colliderx-19, collidery-46, 0, 2)
    elseif direction == 'down' then
        love.graphics.draw(friskSpritesheet, frames.down[curFrame], colliderx-19, collidery-46, 0, 2)
    elseif direction == 'left' then
        love.graphics.draw(friskSpritesheet, frames.left[curFrame], colliderx-19, collidery-46, 0, 2)
    elseif direction == 'right' then
        love.graphics.draw(friskSpritesheet, frames.right[curFrame], colliderx-19, collidery-46, 0, 2)
    end
end


return frisk
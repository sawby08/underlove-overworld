-- frisk.lua

local frisk = {}

local speed = 120 -- original speed is 4, but multiplied by 30 due to dumb deltatime stuff

local direction = 'down'
local canAnimate = false
local lastx, lasty = 0, 0
local vx, vy = 0, 0
local colliderx, collidery = 0, 0

local frames = {}
local friskSpritesheet
local curFrame = 1

local timeSince = 0

local function setupQuads(width, height, frames, source, offset)
    local i = 0
    local loadedFrames = {}
    repeat
        table.insert(loadedFrames, love.graphics.newQuad(offset + width * i, 0, width, height, source))
        i = i + 1
    until i == frames
    return unpack(loadedFrames)
end

local function animate(dt)
    if vx > 0 and vy == 0 then
        direction = 'right'
    elseif vx < 0 and vy == 0 then
        direction = 'left'
    end

    if vy > 0 and vx == 0 then
        direction = 'down'
    elseif vy < 0 and vx == 0 then
        direction = 'up'
    end

    if vx < 0 and direction == 'right' then
        direction = 'left'
    end
    if vx > 0 and direction == 'left' then
        direction = 'right'
    end
    if vy < 0 and direction == 'down' then
        direction = 'op'
    end
    if vy > 0 and direction == 'up' then
        direction = 'down'
    end

    if canAnimate then
        timeSince = timeSince + dt*(speed/120)
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

function frisk.load()
    friskSpritesheet = love.graphics.newImage("assets/images/frisk.png")
    
    frames = {
        up = {setupQuads(20, 30, 4, friskSpritesheet, 240)},
        down = {setupQuads(20, 30, 4, friskSpritesheet, 0)},
        right = {setupQuads(20, 30, 4, friskSpritesheet, 160)},
        left = {setupQuads(20, 30, 4, friskSpritesheet, 80)}
    }

    world:addCollisionClass('player')
        frisk.collider = world:newRectangleCollider(320, 240, 32, 28)
        frisk.collider:setFixedRotation(true)
    frisk.collider:setCollisionClass('player')

    direction = 'down'
end

function frisk.update(dt)
    lastx = colliderx
    lasty = collidery
    vx = 0
    vy = 0

    if love.keyboard.isDown('up') then
        vy = vy - speed
    end
    if love.keyboard.isDown('down') then
        vy = vy + speed
    end
    if love.keyboard.isDown('left') then
        vx = vx - speed
    end
    if love.keyboard.isDown('right') then
        vx = vx + speed
    end

    animate(dt)

    if love.keyboard.isDown('x') or love.keyboard.isDown('lshift') or love.keyboard.isDown('rshift') then
        speed = 180
    else
        speed = 120
    end

    frisk.collider:setLinearVelocity(vx, vy)
    colliderx, collidery = frisk.collider:getX(), frisk.collider:getY()

    if colliderx ~= lastx or collidery ~= lasty then
        canAnimate = true
    else
        canAnimate = false
    end
end

function frisk.draw()
    local directionFrames = {up = frames.up, down = frames.down, left = frames.left, right = frames.right}
    local currentFrames = directionFrames[direction]
    if currentFrames then
        love.graphics.draw(friskSpritesheet, currentFrames[curFrame], math.floor(frisk.collider:getX()) - 20, math.floor(frisk.collider:getY()) - 48, 0, 2)
    end
end


return frisk
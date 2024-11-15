-- room.lua

room = {}


function room.load(path)
    map = sti(path)

    local polyAmt = 0
    local rectAmt = 0
    local elipseAmt = 0

    polyWalls = {}
    rectWalls = {}
    ellipseWalls = {}

    for i, obj in pairs(map.layers["polygon"].objects) do
        if obj.shape == "polygon" then
            polyAmt = polyAmt + 1
            print("polygon #" .. polyAmt)

            verts = {}
            for i, obj in ipairs(obj.polygon) do
                -- local points = {x = obj.x, y = obj.y}
                table.insert(verts, obj.x)
                table.insert(verts, obj.y)
            end

            for i, vert in ipairs(verts) do
                print(vert)
            end
        
            local wall = HC.polygon(verts)
            table.insert(polyWalls, wall)
        end
        if obj.shape == "rectangle" then
            rectAmt = rectAmt + 1
            print("rectangle #" .. rectAmt)
            local wall = HC.rectangle(obj.x, obj.y, obj.width, obj.height)
            table.insert(rectWalls, wall)
        end
        if obj.shape == "ellipse" then
            rectAmt = rectAmt + 1
            print("ellipse #" .. rectAmt)
            local wall = HC.circle(obj.x + obj.width/2, obj.y + obj.width/2, obj.width/2)
            table.insert(ellipseWalls, wall)
        end
    end
end

function room.update(dt)

end

function room.draw()
    map:draw()
    for i, wall in ipairs(polyWalls) do
        love.graphics.setColor(0, 1, 0)
        wall:draw()
    end
    for i, wall in ipairs(rectWalls) do
        love.graphics.setColor(0, 1, 0)
        wall:draw()
    end
    for i, wall in ipairs(ellipseWalls) do
        love.graphics.setColor(0, 1, 0)
        wall:draw()
    end
    love.graphics.setColor(1, 1, 1)
end


return room
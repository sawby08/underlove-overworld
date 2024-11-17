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

    for i, obj in pairs(map.layers["collision"].objects) do
        if obj.shape == "polygon" then
            polyAmt = polyAmt + 1
            print("polygon #" .. polyAmt)

            local verts = {}
            for i, objPoint in ipairs(obj.polygon) do
                table.insert(verts, objPoint.x)
                table.insert(verts, objPoint.y)
            end

            for i, vert in ipairs(verts) do
                print(vert)
            end

            local wall = world:newPolygonCollider(verts)
            wall:setType('static')
            
            table.insert(polyWalls, wall)
        end
        if obj.shape == "rectangle" then
            rectAmt = rectAmt + 1
            print("rectangle #" .. rectAmt)
            local wall = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
            wall:setType('static')
            table.insert(rectWalls, wall)
        end
        if obj.shape == "ellipse" then
            rectAmt = rectAmt + 1
            print("ellipse #" .. rectAmt)
            local wall = world:newCircleCollider(obj.x + obj.width/2, obj.y + obj.width/2, obj.width/2)
            wall:setType('static')
            table.insert(ellipseWalls, wall)
        end
    end

    collider = HC.new(0)
end

function room.update(dt)

end

function room.draw()
    -- map:draw()
end


return room
-- Metaclass
Paddle = { x = 10, y = 0, width = 20, height = 80, move_speed = 2 }

function Paddle:CenterVeritcally()
    self.y = (love.graphics.getHeight() / 2) - (self.height / 2)
end

function Paddle:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

-- Generate a new "instance"
function Paddle:new(x, y, width, height, move_speed)
    local o = {}
    setmetatable(o, { __index = self })
    o.x = x or 0
    o.y = y or 0
    o.width = width or 20
    o.height = height or 80
    o.move_speed = move_speed or 2
    return o
end

return Paddle

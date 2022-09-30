-- Metaclass
Ball = { x = 0, y = 0, width = 20, height = 20, speed_x = 4, speed_y = 4 }

function Ball:CenterOnScreen()
    self.x = love.graphics.getWidth() / 2
    self.x = self.x - self.width / 2

    self.y = love.graphics.getHeight() / 2
    self.y = self.y - self.height / 2
end

function Ball:ResetSpeedAndDirection()
    self.speed_x = -4
    self.speed_y = 4
end

function Ball:Animation()
    if self.x < 0 then
        -- ball.speed_x = ball.speed_x * -1
        self:CenterOnScreen()
        self:ResetSpeedAndDirection()
    end
    if self.y < 0 then
        self.speed_y = self.speed_y * -1
    end
    if self.x > love.graphics.getWidth() - self.width then
        self.speed_x = self.speed_x * -1
        -- Lost
    end
    if self.y > love.graphics.getHeight() - self.height then
        self.speed_y = self.speed_y * -1
    end

    self.x = self.x + self.speed_x
    self.y = self.y + self.speed_y
end

function Ball:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

-- Generate a new "instance"
function Ball:new(x, y, width, height, speed_x, speed_y)
    local o = {}
    setmetatable(o, { __index = self })
    o.x = x or 0
    o.y = y or 0
    o.width = width or 20
    o.height = height or 20
    o.speed_x = speed_x or 2
    o.speed_y = speed_y or 2
    return o
end

return Ball

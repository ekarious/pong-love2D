-- Metaclass
Ball = { x = 0, y = 0, width = 20, height = 20, speed_x = 200, speed_y = 200 }

function Ball:CenterOnScreen()
    self.x = love.graphics.getWidth() / 2
    self.x = self.x - self.width / 2

    self.y = love.graphics.getHeight() / 2
    self.y = self.y - self.height / 2
end

function Ball:ResetSpeedAndDirection(dt)
    self.speed_x = self.speed_x + dt
    self.speed_y = self.speed_y + dt
end

function Ball:Animation(dt)
    if self.x < 0 then
        self:CenterOnScreen()
        self:ResetSpeedAndDirection(dt)
    end
    if self.y < 0 then
        self.speed_y = (self.speed_y + dt) * -1
    end
    if self.x > love.graphics.getWidth() - self.width then
        -- self.speed_x = self.speed_x * -1
        self:CenterOnScreen()
        self:ResetSpeedAndDirection(dt)
    end
    if self.y > love.graphics.getHeight() - self.height then
        self.speed_y = (self.speed_y + dt) * -1
    end

    self.x = self.x + (self.speed_x * dt)
    self.y = self.y + (self.speed_y * dt)
end

function Ball:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

-- Generate a new "instance"
function Ball:new(x, y, width, height, speed_x, speed_y)
    local o = {}
    setmetatable(o, { __index = self })
    o.x = x or Ball.x
    o.y = y or Ball.y
    o.width = width or Ball.width
    o.height = height or Ball.height
    o.speed_x = speed_x or Ball.speed_x
    o.speed_y = speed_y or Ball.speed_y
    return o
end

return Ball

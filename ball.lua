SOUND_LOSS = love.audio.newSource('sounds/loss_point.wav', "static")
SOUND_BOUNCE_WALL = love.audio.newSource('sounds/bounce_wall.wav', "static")

local Interface = require('interface')

-- Metaclass
Ball = { x = 0, y = 0, width = 10, height = 10, moveVector = { -1, 1 }, speed = 300 }

function Ball:CenterOnScreen()
    self.x = love.graphics.getWidth() / 2
    self.x = self.x - self.width / 2

    self.y = love.graphics.getHeight() / 2
    self.y = self.y - self.height / 2
end

function Ball:ResetSpeedAndDirection(dt)
    self.speed = self.speed + dt
    self.moveVector = { 1, 1 }
end

function Ball:Animation(dt)
    if self.x < 0 then
        love.audio.play(SOUND_LOSS)
        Interface:UpdateScore("player2", Interface.score.player2 + 1)
        self:CenterOnScreen()
        self:ResetSpeedAndDirection(dt)
    end
    if self.y < 0 then
        self.moveVector[2] = self.moveVector[2] * -1
        love.audio.play(SOUND_BOUNCE_WALL)
    end
    if self.x > love.graphics.getWidth() - self.width then
        love.audio.play(SOUND_LOSS)
        Interface:UpdateScore("player1", Interface.score.player1 + 1)
        self:CenterOnScreen()
        self:ResetSpeedAndDirection(dt)
    end
    if self.y > love.graphics.getHeight() - self.height then
        self.moveVector[2] = self.moveVector[2] * -1
        love.audio.play(SOUND_BOUNCE_WALL)
    end

    self.x = self.x + (self.speed * self.moveVector[1] * dt)
    self.y = self.y + (self.speed * self.moveVector[2] * dt)
end

function Ball:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

-- Generate a new "instance"
function Ball:new(x, y, width, height, speed)
    local o = {}
    setmetatable(o, { __index = self })
    o.x = x or Ball.x
    o.y = y or Ball.y
    o.width = width or Ball.width
    o.height = height or Ball.height
    o.speed = speed or Ball.speed
    return o
end

return Ball

-- Metaclass
Paddle = { x = 10, y = 0, width = 20, height = 80, move_speed = 300 }

function Paddle:CenterVeritcally()
    self.y = (love.graphics.getHeight() / 2) - (self.height / 2)
end

function Paddle:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Paddle:BallCollision(ball)
    if ball.x + ball.width >= self.x and ball.x <= self.x + self.width then
        if ball.y + ball.height >= self.y and ball.y <= self.y + self.height then
            ball.speed_x = ball.speed_x * -1 -- invert direction
            if self.x >= love.graphics.getWidth() / 2 then
                ball.x = self.x - ball.width
            else
                ball.x = self.x + ball.width
            end
        end
    end
end

-- Generate a new "instance"
function Paddle:new(x, y, width, height, move_speed)
    local o = {}
    setmetatable(o, { __index = self })
    o.x = x or Paddle.x
    o.y = y or Paddle.y
    o.width = width or Paddle.width
    o.height = height or Paddle.height
    o.move_speed = move_speed or Paddle.move_speed
    return o
end

return Paddle

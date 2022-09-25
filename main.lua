-- Debugger
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

-- Paddle
Pad = {}
Pad.x = 0
Pad.y = 0
Pad.width = 20
Pad.height = 80

-- Ball
Ball = {}
Ball.x = 0
Ball.y = 0
Ball.width = 20
Ball.height = 20
Ball.speed_x = 2
Ball.speed_y = 2

function CenterBallInScreen()
    -- Center the ball
    Ball.x = love.graphics.getWidth() / 2
    Ball.x = Ball.x - Ball.width / 2

    Ball.y = love.graphics.getHeight() / 2
    Ball.y = Ball.y - Ball.height / 2
end

function ResetBallSpeedAndDirection()
    Ball.speed_x = 2
    Ball.speed_y = 2
end

function love.load()
    CenterBallInScreen()
end

function love.update(dt)
    -- Ball animation
    if Ball.x < 0 then
        -- Ball.speed_x = Ball.speed_x * -1
        -- Lost !
        CenterBallInScreen()
        ResetBallSpeedAndDirection()
    end
    if Ball.y < 0 then
        Ball.speed_y = Ball.speed_y * -1
    end
    if Ball.x > love.graphics.getWidth() - Ball.width then
        Ball.speed_x = Ball.speed_x * -1
        -- Lost
    end
    if Ball.y > love.graphics.getHeight() - Ball.height then
        Ball.speed_y = Ball.speed_y * -1
    end
    Ball.x = Ball.x + Ball.speed_x
    Ball.y = Ball.y + Ball.speed_y

    -- If ball contact with Paddle
    if Ball.x <= Pad.x + Pad.width then
        if Ball.y + Ball.height > Pad.y and Ball.y < Pad.y + Pad.height then
            Ball.speed_x = Ball.speed_x * -1 -- invert direction
            Ball.x = Pad.x + Pad.width
        end
    end


    if love.keyboard.isDown("down") and love.graphics.getHeight() > (Pad.y + Pad.height) then
        Pad.y = Pad.y + 2
    end

    if love.keyboard.isDown("up") and Pad.y > 0 then
        Pad.y = Pad.y - 2
    end
end

function love.draw()
    love.graphics.rectangle("fill", Pad.x, Pad.y, Pad.width, Pad.height)
    love.graphics.rectangle("fill", Ball.x, Ball.y, Ball.width, Ball.height)
end

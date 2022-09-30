-- Debugger
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

-- Set some Love2D options
love.window.setMode(1024, 720, { centered = true, resizable = false })

-- Import Module for the game
local Paddle = require('paddle')
local Ball = require('ball')

-- Instanciate objects
local pad_player1 = Paddle:new(10)
local pad_player2 = Paddle:new(love.graphics.getWidth() - Paddle.width - 10)
local ball = Ball:new()

-- Love2D functions
function love.load()
    ball:CenterOnScreen()

    pad_player1:CenterVeritcally()
    pad_player2:CenterVeritcally()
end

function love.update(dt)
    ball:Animation()

    -- If ball contact with Paddle
    ball:PaddleCollision(pad_player1) -- FIX collision with paddle player 2

    --  Player 1 Movement
    if love.keyboard.isDown("s") and love.graphics.getHeight() > (pad_player1.y + pad_player1.height) then
        pad_player1.y = pad_player1.y + pad_player1.move_speed
    end

    if love.keyboard.isDown("w") and pad_player1.y > 0 then
        pad_player1.y = pad_player1.y - pad_player1.move_speed
    end

    --  Player 2 Movement
    if love.keyboard.isDown("down") and love.graphics.getHeight() > (pad_player2.y + pad_player2.height) then
        pad_player2.y = pad_player2.y + pad_player2.move_speed
    end

    if love.keyboard.isDown("up") and pad_player2.y > 0 then
        pad_player2.y = pad_player2.y - pad_player2.move_speed
    end
end

function love.draw()
    pad_player1:draw()
    pad_player2:draw()
    ball:draw()
end

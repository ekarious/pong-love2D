-- Metaclass
Interface = { score = { player1 = "0", player2 = "0" } }

function Interface:SideSeparator()
    love.graphics.line(love.graphics.getWidth() / 2, 50, love.graphics.getWidth() / 2, love.graphics.getHeight() - 50)
end

function Interface:CreateScore()
    local font = love.graphics.newFont(60)
    local textPlayer1 = love.graphics.newText(font, self.score.player1)
    local textPlayer2 = love.graphics.newText(font, self.score.player2)
    love.graphics.draw(textPlayer1, 440, 40)
    love.graphics.draw(textPlayer2, 545, 40)
end

function Interface:UpdateScore(player, value)
    if player == "player1" then
        self.score.player1 = value
    end

    if player == "player2" then
        self.score.player2 = value
    end
end

function Interface:new()
    local o = {}
    setmetatable(o, { __index = self })
    return o
end

return Interface

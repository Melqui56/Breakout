-- Paddle: the player-controlled platform (skeleton).
local Paddle = {}
Paddle.__index = Paddle

function Paddle.new(x, y, width, speed)
    local self = setmetatable({
        x = x, y = y, width = width, speed = speed,
    }, Paddle)
    return self
end

function Paddle:update(dt, input)
    -- TODO: apply movement from input intent.
end

function Paddle:moveLeft(dt)
    -- TODO: move the paddle left by speed * dt.
end

function Paddle:moveRight(dt)
    -- TODO: move the paddle right by speed * dt.
end

function Paddle:draw()
    -- TODO: render the paddle.
end

return Paddle

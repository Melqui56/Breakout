-- Paddle: the player-controlled platform.
local Config = require("src.config")

local Paddle = {}
Paddle.__index = Paddle

function Paddle.new(x, y, width, speed)
    local self = setmetatable({
        x = x, y = y, width = width, speed = speed,
        height = Config.paddleHeight,
    }, Paddle)
    return self
end

-- Move according to the input state handed down by Game.
function Paddle:update(dt, input)
    if not input then return end
    if input.left then self:moveLeft(dt) end
    if input.right then self:moveRight(dt) end
end

function Paddle:moveLeft(dt)
    self.x = math.max(0, self.x - self.speed * dt)
end

function Paddle:moveRight(dt)
    self.x = math.min(Config.width - self.width, self.x + self.speed * dt)
end

function Paddle:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, 3, 3)
end

-- Horizontal offset of a hit, in [-1, 1], used to angle the bounce.
function Paddle:hitOffset(x)
    return (x - (self.x + self.width / 2)) / (self.width / 2)
end

return Paddle

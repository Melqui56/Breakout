-- Ball: the moving projectile of the game.
local Config = require("src.config")

local Ball = {}
Ball.__index = Ball

function Ball.new(x, y, radius)
    local self = setmetatable({
        x = x, y = y, radius = radius,
        speedX = 0, speedY = 0,
        launched = false,
    }, Ball)
    return self
end

-- Integrate velocity and bounce off the walls and the ceiling.
-- Returns true when the ball falls below the play area (ball lost).
function Ball:update(dt)
    if not self.launched then
        return false
    end

    self.x = self.x + self.speedX * dt
    self.y = self.y + self.speedY * dt

    if self.x - self.radius < 0 then
        self.x = self.radius
        self:bounce("x")
    elseif self.x + self.radius > Config.width then
        self.x = Config.width - self.radius
        self:bounce("x")
    end

    if self.y - self.radius < 0 then
        self.y = self.radius
        self:bounce("y")
    end

    return self.y - self.radius > Config.height
end

function Ball:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("fill", self.x, self.y, self.radius)
end

-- Reverse one velocity component. Defaults to the vertical axis.
function Ball:bounce(axis)
    if axis == "x" then
        self.speedX = -self.speedX
    else
        self.speedY = -self.speedY
    end
end

function Ball:reset(x, y)
    self.x, self.y = x, y
    self.speedX, self.speedY = 0, 0
    self.launched = false
end

-- Send the ball upwards at a slight angle to start a run.
function Ball:launch()
    if self.launched then return end
    local angle = math.random() * 0.6 - 0.3
    self.speedX = math.sin(angle) * Config.ballSpeed
    self.speedY = -math.cos(angle) * Config.ballSpeed
    self.launched = true
end

-- Axis-aligned test against a rectangle.
function Ball:collidesWith(rect)
    return self.x + self.radius > rect.x
       and self.x - self.radius < rect.x + rect.width
       and self.y + self.radius > rect.y
       and self.y - self.radius < rect.y + rect.height
end

return Ball

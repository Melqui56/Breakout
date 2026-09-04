-- Ball: the moving projectile of the game (skeleton).
local Ball = {}
Ball.__index = Ball

function Ball.new(x, y, radius)
    local self = setmetatable({
        x = x, y = y, radius = radius,
        speedX = 0, speedY = 0,
    }, Ball)
    return self
end

function Ball:update(dt)
    -- TODO: integrate velocity and apply collision responses.
end

function Ball:draw()
    -- TODO: render the ball.
end

function Ball:bounce()
    -- TODO: reverse a velocity component on collision.
end

function Ball:reset(x, y)
    self.x, self.y = x, y
    self.speedX, self.speedY = 0, 0
end

return Ball

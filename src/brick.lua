-- Brick: a destructible block of a level (skeleton).
local Brick = {}
Brick.__index = Brick

function Brick.new(x, y, width, height, hp)
    local self = setmetatable({
        x = x, y = y, width = width, height = height,
        hp = hp or 1, alive = true,
    }, Brick)
    return self
end

function Brick:update(dt)
    -- TODO: per-frame brick behavior.
end

function Brick:draw()
    -- TODO: render the brick.
end

function Brick:takeHit()
    -- TODO: reduce hp and mark for removal when destroyed.
end

return Brick

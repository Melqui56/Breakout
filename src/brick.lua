-- Brick: a destructible block of a level.
local Brick = {}
Brick.__index = Brick

-- Colour per remaining hit point, so durability is readable at a glance.
local COLORS = {
    { 0.35, 0.72, 0.98 },
    { 0.98, 0.75, 0.30 },
    { 0.94, 0.42, 0.42 },
}

function Brick.new(x, y, width, height, hp)
    local self = setmetatable({
        x = x, y = y, width = width, height = height,
        hp = hp or 1, alive = true,
    }, Brick)
    return self
end

function Brick:update(dt)
    -- Bricks are static: nothing to advance per frame.
end

function Brick:draw()
    if not self.alive then return end
    local c = COLORS[math.min(self.hp, #COLORS)]
    love.graphics.setColor(c[1], c[2], c[3])
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, 2, 2)
    love.graphics.setColor(0, 0, 0, 0.35)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height, 2, 2)
end

-- Absorb one hit. Returns true when the brick is destroyed.
function Brick:takeHit()
    self.hp = self.hp - 1
    if self.hp <= 0 then
        self.alive = false
        return true
    end
    return false
end

return Brick

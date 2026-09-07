-- Brick: un bloque destructible de un nivel (esqueleto).
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
    -- TODO: comportamiento por frame del ladrillo.
end

function Brick:draw()
    -- TODO: renderizar el ladrillo.
end

function Brick:takeHit()
    -- TODO: reducir hp y marcar para eliminar cuando se destruya.
end

return Brick

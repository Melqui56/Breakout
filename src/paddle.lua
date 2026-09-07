-- Paddle: la plataforma controlada por el jugador (esqueleto).
local Paddle = {}
Paddle.__index = Paddle

function Paddle.new(x, y, width, speed)
    local self = setmetatable({
        x = x, y = y, width = width, speed = speed,
    }, Paddle)
    return self
end

function Paddle:update(dt, input)
    -- TODO: aplicar movimiento según la intención del input.
end

function Paddle:moveLeft(dt)
    -- TODO: mover la paleta a la izquierda con speed * dt.
end

function Paddle:moveRight(dt)
    -- TODO: mover la paleta a la derecha con speed * dt.
end

function Paddle:draw()
    -- TODO: renderizar la paleta.
end

return Paddle

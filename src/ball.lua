-- Ball: el proyectil móvil del juego (esqueleto).
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
    -- TODO: integrar la velocidad y aplicar respuestas de colisión.
end

function Ball:draw()
    -- TODO: renderizar la bola.
end

function Ball:bounce()
    -- TODO: invertir un componente de velocidad al colisionar.
end

function Ball:reset(x, y)
    -- TODO: reposicionar la bola y reiniciar su velocidad.
end

return Ball

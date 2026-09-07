-- Level: posee los ladrillos de una etapa e informa si está completo (esqueleto).
local Brick = require("src.brick")

local Level = {}
Level.__index = Level

function Level.new()
    local self = setmetatable({ bricks = {} }, Level)
    return self
end

function Level:load(levelData)
    -- TODO: poblar self.bricks a partir de levelData.
end

function Level:update(dt)
    -- TODO: actualizar ladrillos y limpiar los destruidos.
end

function Level:draw()
    -- TODO: renderizar todos los ladrillos.
end

function Level:isComplete()
    -- TODO: devolver true cuando no queden ladrillos.
    return false
end

return Level

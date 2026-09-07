-- UI: renderiza puntaje, vidas, nivel y mensajes (esqueleto).
local UI = {}
UI.__index = UI

function UI.new()
    local self = setmetatable({ score = 0, lives = 0, level = 1, message = "" }, UI)
    return self
end

function UI:setHud(score, lives, level)
    -- TODO: actualizar puntaje, vidas y nivel del HUD.
end

function UI:setMessage(msg)
    -- TODO: definir el mensaje mostrado en pantalla.
end

function UI:draw()
    -- TODO: renderizar elementos del HUD y mensajes.
end

return UI

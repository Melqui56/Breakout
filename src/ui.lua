-- UI: dibuja el HUD (puntaje, vidas, nivel) y los mensajes de pantalla.
-- No contiene lógica de juego: solo presenta los datos que recibe.
local Config = require("src.config")

local UI = {}
UI.__index = UI

function UI.new()
    return setmetatable({ score = 0, lives = 0, level = 1, message = "" }, UI)
end

function UI:setHud(score, lives, level)
    self.score = score
    self.lives = lives
    self.level = level
end

function UI:setMessage(msg)
    self.message = msg or ""
end

function UI:draw()
    local c = Config.colorText
    love.graphics.setColor(c)
    love.graphics.print("Puntos: " .. self.score, 20, 18)
    love.graphics.print("Vidas: " .. self.lives, 20, 40)
    love.graphics.print("Nivel: " .. self.level, Config.width - 110, 18)
    if self.message ~= "" then
        love.graphics.printf(self.message, 0, Config.height / 2 - 20, Config.width, "center")
    end
    love.graphics.setColor(1, 1, 1)
end

return UI

-- UI: renders score, lives, level and messages.
local Config = require("src.config")

local UI = {}
UI.__index = UI

function UI.new()
    local self = setmetatable({ score = 0, lives = 0, level = 1, message = "" }, UI)
    return self
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
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(("Puntaje: %d"):format(self.score), 12, 12)
    love.graphics.printf(("Nivel: %d"):format(self.level), 0, 12, Config.width, "center")
    love.graphics.printf(("Vidas: %d"):format(self.lives), 0, 12, Config.width - 12, "right")

    if self.message ~= "" then
        love.graphics.printf(self.message, 0, Config.height / 2 - 20, Config.width, "center")
    end
end

return UI

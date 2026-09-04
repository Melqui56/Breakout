-- UI: renders score, lives, level and messages (skeleton).
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
    self.message = msg
end

function UI:draw()
    -- TODO: render HUD elements and messages.
end

return UI

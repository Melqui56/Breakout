-- Level: owns the bricks of a stage and reports completion (skeleton).
local Brick = require("src.brick")

local Level = {}
Level.__index = Level

function Level.new()
    local self = setmetatable({ bricks = {} }, Level)
    return self
end

function Level:load(levelData)
    -- TODO: populate self.bricks from levelData.
end

function Level:update(dt)
    -- TODO: update bricks and clean destroyed ones.
end

function Level:draw()
    -- TODO: render all bricks.
end

function Level:isComplete()
    -- TODO: return true when no bricks remain.
    return false
end

return Level

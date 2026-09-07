-- Level: owns the bricks of a stage and reports completion.
local Brick = require("src.brick")
local Config = require("src.config")

local Level = {}
Level.__index = Level

local MARGIN_X, MARGIN_TOP, GAP = 40, 60, 6

function Level.new()
    local self = setmetatable({ bricks = {} }, Level)
    return self
end

-- Build a grid from levelData = { rows, cols, hp }.
function Level:load(levelData)
    self.bricks = {}

    local rows = levelData.rows or 4
    local cols = levelData.cols or 10
    local baseHp = levelData.hp or 1

    local usable = Config.width - MARGIN_X * 2
    local width = (usable - GAP * (cols - 1)) / cols
    local height = 20

    for r = 1, rows do
        for c = 1, cols do
            local x = MARGIN_X + (c - 1) * (width + GAP)
            local y = MARGIN_TOP + (r - 1) * (height + GAP)
            -- Rows closer to the top take more hits.
            local hp = math.min(baseHp + (rows - r), 3)
            table.insert(self.bricks, Brick.new(x, y, width, height, hp))
        end
    end
end

function Level:update(dt)
    for i = #self.bricks, 1, -1 do
        local brick = self.bricks[i]
        brick:update(dt)
        if not brick.alive then
            table.remove(self.bricks, i)
        end
    end
end

function Level:draw()
    for _, brick in ipairs(self.bricks) do
        brick:draw()
    end
end

function Level:isComplete()
    return #self.bricks == 0
end

return Level

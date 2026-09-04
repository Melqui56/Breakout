-- Game: owns the state machine and the main entities (skeleton).
local Ball = require("src.ball")
local Paddle = require("src.paddle")
local Level = require("src.level")
local UI = require("src.ui")

local Game = {}
Game.__index = Game

local STATE = {
    TITLE = "title",
    PLAY = "play",
    PAUSE = "pause",
    GAMEOVER = "gameover",
}

local instance = nil

function Game.load()
    instance = {
        state = STATE.TITLE,
        score = 0,
        lives = 3,
        levelNum = 1,
        input = { left = false, right = false },
        ball = Ball.new(400, 300, 6),
        paddle = Paddle.new(400, 560, 90, 220),
        level = Level.new(),
        ui = UI.new(),
    }
end

function Game.update(dt)
    -- TODO: consult the state machine and update entities
    -- (see docs/state-machine.md and docs/game-loop.md).
end

function Game.draw()
    -- TODO: render entities and UI (see docs/architecture.md).
end

function Game.handleInput(key)
    -- TODO: drive FSM transitions and paddle input.
    if key == "escape" then
        love.event.quit()
    end
end

function Game.releaseInput(key)
    -- TODO: clear held-input flags.
end

return Game

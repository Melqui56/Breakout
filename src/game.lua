-- Game: posee la máquina de estados y las entidades principales (esqueleto).
local Ball = require("src.ball")
local Paddle = require("src.paddle")
local Level = require("src.level")
local UI = require("src.ui")
local Config = require("src.config")

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
        ball = Ball.new(Config.width / 2, Config.height / 2, Config.ballRadius),
        paddle = Paddle.new(Config.width / 2, Config.paddleY, Config.paddleWidth, Config.paddleSpeed),
        level = Level.new(),
        ui = UI.new(),
    }
end

function Game.update(dt)
    -- TODO: consultar la máquina de estados y actualizar entidades
    -- (ver docs/state-machine.md y docs/game-loop.md).
end

function Game.draw()
    -- Texto visible del esqueleto (sin lógica de juego).
    love.graphics.printf("Breakout", 0, 200, Config.width, "center")
    love.graphics.printf("Presiona Enter para jugar", 0, 240, Config.width, "center")
    love.graphics.printf("P = Pausar  |  Esc = Salir", 0, 280, Config.width, "center")
end

function Game.handleInput(key)
    -- Por ahora todas las opciones cierran el juego.
    if key == "return" or key == "escape" or key == "p" then
        love.event.quit()
    end
end

function Game.releaseInput(key)
    -- TODO: limpiar banderas de input mantenido.
end

return Game

-- Punto de entrada: cablea la máquina de estados y delega los callbacks de LÖVE.
local Game = require("src.game")
local StateMachine = require("src.statemachine")

function love.load()
    love.window.setTitle("Breakout")
    math.randomseed(os.time())
    Game.init()

    Game.sm = StateMachine.new({
        title    = require("src.states.title"),
        serve    = require("src.states.serve"),
        play     = require("src.states.play"),
        pause    = require("src.states.pause"),
        gameover = require("src.states.gameover"),
        victory  = require("src.states.victory"),
    })
    Game.sm:switch("title")
end

function love.update(dt)
    Game.sm:update(dt)
end

function love.draw()
    -- Screen shake: desplaza toda la escena según lo indique effects.
    local dx, dy = Game.fx:shakeOffset()
    love.graphics.push()
    love.graphics.translate(dx, dy)
    Game.sm:draw()
    love.graphics.pop()
end

function love.keypressed(key)
    if key == "left" or key == "a" then Game.input.left = true end
    if key == "right" or key == "d" then Game.input.right = true end
    Game.sm:keypressed(key)
end

function love.keyreleased(key)
    if key == "left" or key == "a" then Game.input.left = false end
    if key == "right" or key == "d" then Game.input.right = false end
end

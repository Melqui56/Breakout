-- Punto de entrada: delega los callbacks de LÖVE a la clase Game.
local Game = require("src.game")

function love.load()
    love.window.setTitle("Breakout")
    Game.load()
end

function love.update(dt)
    Game.update(dt)
end

function love.draw()
    Game.draw()
end

function love.keypressed(key)
    Game.handleInput(key)
end

function love.keyreleased(key)
    Game.releaseInput(key)
end

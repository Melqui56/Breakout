-- Game: owns the state machine and the main entities.
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

local STARTING_LIVES = 3
local BRICK_POINTS = 10

local instance = nil

local function levelData(levelNum)
    return {
        rows = math.min(3 + levelNum, 6),
        cols = 10,
        hp = math.min(levelNum, 3),
    }
end

-- Park the ball on the paddle, waiting for the player to launch it.
local function resetBall()
    local paddle = instance.paddle
    instance.ball:reset(paddle.x + paddle.width / 2, paddle.y - Config.ballRadius - 1)
end

local function startLevel(levelNum)
    instance.levelNum = levelNum
    instance.level:load(levelData(levelNum))
    resetBall()
end

local function newRun()
    instance.score = 0
    instance.lives = STARTING_LIVES
    instance.paddle.x = (Config.width - Config.paddleWidth) / 2
    startLevel(1)
end

function Game.load()
    instance = {
        state = STATE.TITLE,
        score = 0,
        lives = STARTING_LIVES,
        levelNum = 1,
        input = { left = false, right = false },
        ball = Ball.new(Config.width / 2, Config.paddleY - 20, Config.ballRadius),
        paddle = Paddle.new((Config.width - Config.paddleWidth) / 2, Config.paddleY,
                            Config.paddleWidth, Config.paddleSpeed),
        level = Level.new(),
        ui = UI.new(),
    }
    startLevel(1)
end

-- Bounce off the paddle, angling the ball by where it hit.
local function resolvePaddleCollision()
    local ball, paddle = instance.ball, instance.paddle
    if ball.speedY <= 0 or not ball:collidesWith(paddle) then return end

    ball.y = paddle.y - ball.radius
    ball:bounce("y")

    local offset = paddle:hitOffset(ball.x)
    ball.speedX = offset * Config.ballSpeed * 0.75
end

-- Bounce off the first brick hit and award its points.
local function resolveBrickCollisions()
    local ball = instance.ball
    for _, brick in ipairs(instance.level.bricks) do
        if brick.alive and ball:collidesWith(brick) then
            -- Bounce on the axis with the shallower overlap.
            local overlapX = math.min(ball.x + ball.radius - brick.x,
                                      brick.x + brick.width - (ball.x - ball.radius))
            local overlapY = math.min(ball.y + ball.radius - brick.y,
                                      brick.y + brick.height - (ball.y - ball.radius))
            ball:bounce(overlapX < overlapY and "x" or "y")

            if brick:takeHit() then
                instance.score = instance.score + BRICK_POINTS
            end
            return
        end
    end
end

-- Ball lost: spend a life and decide between PLAY and GAMEOVER.
local function onBallLost()
    instance.lives = instance.lives - 1
    if instance.lives <= 0 then
        instance.state = STATE.GAMEOVER
    else
        resetBall()
    end
end

function Game.update(dt)
    -- The state machine is consulted first: paused or ended games do not advance.
    if instance.state ~= STATE.PLAY then
        return
    end

    instance.paddle:update(dt, instance.input)

    -- While unlaunched the ball rides the paddle.
    if not instance.ball.launched then
        resetBall()
    end

    local lost = instance.ball:update(dt)
    instance.level:update(dt)

    resolvePaddleCollision()
    resolveBrickCollisions()

    if lost then
        onBallLost()
    elseif instance.level:isComplete() then
        startLevel(instance.levelNum + 1)
    end
end

function Game.draw()
    love.graphics.clear(0.07, 0.08, 0.11)

    if instance.state ~= STATE.TITLE then
        instance.level:draw()
        instance.paddle:draw()
        instance.ball:draw()
    end

    local messages = {
        [STATE.TITLE] = "BREAKOUT\n\nEnter para jugar\nFlechas para mover  -  P para pausar",
        [STATE.PAUSE] = "PAUSA\n\nP para continuar",
        [STATE.GAMEOVER] = ("FIN DEL JUEGO\n\nPuntaje: %d\n\nEnter para volver al inicio")
            :format(instance.score),
        [STATE.PLAY] = instance.ball.launched and "" or "Espacio para lanzar la bola",
    }

    instance.ui:setHud(instance.score, instance.lives, instance.levelNum)
    instance.ui:setMessage(messages[instance.state])
    instance.ui:draw()
end

function Game.handleInput(key)
    if key == "escape" then
        love.event.quit()
        return
    end

    -- FSM transitions: every state change is driven by an explicit event.
    if instance.state == STATE.TITLE then
        if key == "return" or key == "kpenter" then
            newRun()
            instance.state = STATE.PLAY
        end
    elseif instance.state == STATE.PLAY then
        if key == "p" then
            instance.state = STATE.PAUSE
        elseif key == "space" then
            instance.ball:launch()
        end
    elseif instance.state == STATE.PAUSE then
        if key == "p" then
            instance.state = STATE.PLAY
        end
    elseif instance.state == STATE.GAMEOVER then
        if key == "return" or key == "kpenter" then
            instance.state = STATE.TITLE
        end
    end

    if key == "left" or key == "a" then instance.input.left = true end
    if key == "right" or key == "d" then instance.input.right = true end
end

function Game.releaseInput(key)
    if key == "left" or key == "a" then instance.input.left = false end
    if key == "right" or key == "d" then instance.input.right = false end
end

return Game

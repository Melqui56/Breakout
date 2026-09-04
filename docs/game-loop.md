# Game loop

The main loop follows the classic **input → update → render** pattern and is
**delta-time driven** (`dt`), so movement and physics are frame-rate
independent.

## Pseudocode

```
LOVE.load():
    window.setTitle("Breakout")
    Game.load()

LOVE.update(dt):
    input = readInput()
    Game.handleInput(input)        # translate input into game events
    Game.update(dt)                # advance entities using delta time

LOVE.draw():
    Game.draw()                    # render entities and UI in order
```

## Game.update(dt)

```
Game.update(dt):
    if state is PLAY:
        ball.update(dt)            # integrate velocity, check collisions
        paddle.update(dt)          # move paddle from input intent
        level.update(dt)           # update bricks, detect completion
        if ball is lost:
            lives -= 1
            if lives == 0: state = GAMEOVER
            else: resetBall(); keep state = PLAY
        if level.isComplete():
            nextLevel(); keep state = PLAY
    # state = PAUSE: nothing advances
```

## Design rules

- Rendering (`draw`) never mutates game state; logic lives in `update(dt)`.
- All time-dependent behavior receives `dt` explicitly — no hard-coded
  per-frame values.
- The state machine is consulted at the start of `update` so paused or ended
  games do not advance.
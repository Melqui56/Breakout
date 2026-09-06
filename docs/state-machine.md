# State machine

The game flow is a finite state machine (FSM) owned by the `Game` class.
Each transition is triggered by an explicit **event**.

## States

| State    | Meaning                                   |
|----------|-------------------------------------------|
| `title`  | Start screen, waiting for the player      |
| `play`   | Active gameplay                           |
| `pause`  | Gameplay suspended                        |
| `gameover` | Final screen after lives run out        |

## Transitions

![Breakout state machine](uml/state-machine.png)

> Source: [`uml/state-machine.puml`](uml/state-machine.puml).

<details>
<summary>Mermaid source</summary>

```mermaid
stateDiagram-v2
    [*] --> title
    title --> play : Enter pressed
    play --> play : Ball lost (lives > 0)
    play --> pause : P pressed
    pause --> play : P pressed
    play --> play : Level complete (next level)
    play --> gameover : Ball lost (lives == 0)
    gameover --> title : Enter pressed
```

</details>

## Edge cases covered

- **Ball lost** — if the player still has lives, return to `play` and reset
  the ball; otherwise transition to `gameover`.
- **Level complete** — when all bricks are destroyed, advance to the next
  level and stay in `play`.
- **Pause** — the game can be paused mid-run and resumed from the same state;
  `update(dt)` is skipped while paused so the game does not advance.
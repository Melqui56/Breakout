# Breakout

> A classic brick-breaking arcade game in **Lua**, built with **LÖVE 2D**, modeled around clean object-oriented design.

Breakout is a lightweight, architecture-first implementation of the classic
*Breakout* arcade game. The project models entities, responsibilities and the
game state machine **before** the logic is implemented — the result is a
small, readable, and extensible codebase where every class has a single
responsibility.

## Table of contents

- [Features](#features)
- [Getting started](#getting-started)
- [Gameplay](#gameplay)
- [Project structure](#project-structure)
- [Documentation](#documentation)
- [Building portable releases](#building-portable-releases)
- [Contributing](#contributing)
- [License](#license)

## Features

- **Object-oriented entities** — six classes, one per file, each with a single
  responsibility (`Ball`, `Paddle`, `Brick`, `Level`, `Game`, `UI`).
- **Finite state machine** — title, play, pause and game over with explicit,
  event-driven transitions and covered edge cases.
- **Delta-time driven loop** — input → update → render, frame-rate independent.
- **Skeleton scope** — one class per file with correctly signed placeholder
  methods, per the assignment: a runnable LÖVE project that opens a window with
  the game title, ready to be implemented.
- **Cross-platform** — setup and run helpers for Linux, macOS and Windows.
- **Portable releases** — manual build helpers produce `.love`, Linux and
  Windows self-contained bundles.

## Getting started

### Prerequisites

- [LÖVE 2D](https://love2d.org/) 11.x (bundles Lua)

### Install LÖVE automatically

| OS | Command |
|---|---|
| Linux (Fedora/RHEL, Debian/Ubuntu, Arch) | `./scripts/setup.sh` |
| macOS | `./scripts/setup.sh` |
| Windows | `powershell -ExecutionPolicy Bypass -File scripts\setup.ps1` |

> Prefer installing LÖVE from [love2d.org](https://love2d.org/) if you do not
> want to use the helper scripts.

### Run

| OS | Command |
|---|---|
| Linux / macOS | `./scripts/run.sh` |
| Windows | `powershell -ExecutionPolicy Bypass -File scripts\run.ps1` |
| Any (with LÖVE on PATH) | `love .` |

## Gameplay

- **Controls**
  - `←` / `→` — move the paddle
  - `Enter` — start / restart
  - `P` — pause / resume
  - `Esc` — quit
- **Rules**
  - Clear all bricks to advance to the next level.
  - Each brick is worth 10 points.
  - You have 3 lives; lose the ball and it resets. Lose all lives → game over.
  - The ball deflects off the paddle based on the impact point.

## Project structure

```
Breakout/
├── main.lua              # LÖVE callbacks wired to the Game class
├── conf.lua              # LÖVE configuration
├── scripts/
│   ├── setup.sh          # Install LÖVE on Linux/macOS
│   ├── setup.ps1         # Install LÖVE on Windows
│   ├── run.sh            # Run the game (Linux/macOS)
│   ├── run.ps1           # Run the game (Windows)
│   ├── build.sh          # Package portable Linux/.love builds
│   └── build.ps1         # Package portable Windows builds
├── src/
│   ├── config.lua        # Shared game constants
│   ├── ball.lua          # Moving projectile
│   ├── paddle.lua        # Player-controlled platform
│   ├── brick.lua         # Destructible block
│   ├── level.lua         # Bricks of a stage and completion
│   ├── game.lua          # State machine, scoring, collisions
│   └── ui.lua            # HUD and messages
└── docs/
    ├── architecture.md   # UML class diagram and responsibilities
    ├── state-machine.md  # States, transitions and edge cases
    ├── game-loop.md      # Main loop pseudocode
    ├── lua-fundamentals.md  # How the Lua runtime works
    ├── oop-in-lua.md     # OOP (metatable) pattern in this codebase
    └── design-justification.md  # Why each design decision was made
```

## Documentation

- [Architecture](docs/architecture.md) — UML class diagram, responsibilities and relationships.
- [State machine](docs/state-machine.md) — game flow, transitions and edge cases.
- [Game loop](docs/game-loop.md) — main loop pseudocode.
- [Lua fundamentals](docs/lua-fundamentals.md) — how the Lua runtime works.
- [Object-oriented programming in Lua](docs/oop-in-lua.md) — the metatable class pattern.
- [Design justification](docs/design-justification.md) — rationale for every architectural decision.

## Building portable releases

Releases are **built and published manually** (no automated CI/CD).

```bash
./scripts/build.sh 0.1.0                # Linux/macOS
powershell -ExecutionPolicy Bypass -File scripts\build.ps1   # Windows
```

Artifacts are written to `dist/`:

- `Breakout.love` — portable package (runs on any OS with LÖVE).
- `Breakout-linux-x86_64.tar.gz` — self-contained Linux bundle.
- `Breakout-win64/Breakout.exe` and `Breakout-win64.zip` — Windows portable.

See [RELEASING.md](RELEASING.md) for the full manual release checklist.

## Contributing

We use a simple branch workflow:

- `main` — protected. Only maintainers push or merge here.
- `dev` — integration branch for the team.
- `feature/*` — short-lived branches created from `dev`; merged via **pull requests**.

Please read [CONTRIBUTING.md](CONTRIBUTING.md) before opening a pull request.

## License

[MIT](LICENSE)
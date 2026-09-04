# Changelog

All notable changes to this project are documented here.
The format is based on [Keep a Changelog](https://keepachangelog.com/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

## [0.1.0] - 2026-09-03

### Added

- Object-oriented architecture for Breakout (Lua / LÖVE 2D).
- Six classes, one per file: `Ball`, `Paddle`, `Brick`, `Level`, `Game`, `UI`.
- Game state machine (title, play, pause, game over) with edge cases
  (ball lost, lives exhausted, level complete).
- Delta-time driven game loop (input → update → render).
- Skeleton scope per assignment: one class per file with correctly signed
  placeholder methods and a runnable LÖVE project that opens a titled window.
- HUD interface (score, lives, level, messages) as placeholder methods.
- Documentation: architecture (UML), state machine, game loop, Lua
  fundamentals, OOP in Lua, design justification.
- Cross-platform environment scripts: `setup.sh` / `setup.ps1`.
- Manual release tooling: `build.sh` / `build.ps1` (portable `.love`,
  Linux tarball, Windows self-contained `.exe`), `RELEASING.md`.
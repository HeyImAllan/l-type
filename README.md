# L-Type 🦁

A Halloween-themed horizontal shoot-em-up (shmup) built in [Pico-8](https://www.lexaloffle.com/pico-8.php).

## Story & Theme

Pilot Leo — a brave orange lion — through a moonlit graveyard teeming with bats, pumpkins, and supernatural horrors. Wave after wave of enemies block your path, culminating in a showdown against the sinister **Auditron** boss. Survive the graveyard of greed!

## Gameplay

| Control | Action |
|---------|--------|
| Arrow keys | Move Leo |
| ❎ (X) | Shoot |
| 🅾️ (Z) | Afterburner boost |

- Destroy enemies to earn points.
- Avoid enemy collisions — Leo has 4 hearts of health.
- Defeat all waves to reach the Auditron boss.
- Occasionally a **heart pickup** drops from a defeated enemy. Fly into it to recover 1 heart.

## Project Structure

```
halloweenleo.p8   ← Pico-8 cartridge (entry point)
entities/         ← Game entities (leo, bats, pumpkins, orbys, hearts, …)
scenes/           ← Level and scene logic
scripts/          ← Reusable subsystems (bullets, collision, gfx, …)
tools/            ← Utility helpers
```

## Running the Game

Open `halloweenleo.p8` in Pico-8 (version 0.2.6+) and press **Run** (`Ctrl+R`), or load it via the Pico-8 splore.

## Development

This project uses Pico-8's `#include` system to split source code across multiple `.lua` files. All includes are declared at the top of `halloweenleo.p8`.

See [CHANGELOG.md](CHANGELOG.md) for version history.

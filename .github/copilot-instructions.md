# GitHub Copilot Instructions

## Environment
- **Pico-8 executable:** `C:\Program Files (x86)\PICO-8\pico8.exe`
- **Launch command:** `& "C:\Program Files (x86)\PICO-8\pico8.exe" -run "halloweenleo.p8"`

## Project Overview
This is a Pico-8 cartridge (`halloweenleo.p8`) written in Lua. It is a Halloween-themed horizontal shoot-em-up (shmup) featuring Leo, an orange lion, as the player character.

## Project Structure
- `halloweenleo.p8` — Main Pico-8 cartridge. Uses `#include` directives to pull in all Lua source files.
- `entities/` — Individual game entities (leo, bats, pumpkins, orbys, gravestone, explosions, heart, auditron).
- `scenes/` — Level and scene logic (l01s01 for level 1, gameover screen).
- `scripts/` — Reusable scripts (bullets, collision, starfield, clouds, afterburner, leo_gfx, blink_enemy, debugging).
- `tools/` — Utility functions (tableconcat, contains).

## Pico-8 / Lua Conventions
- Sprites are referenced by integer index. Sprite 20 is a full heart, sprite 21 is an empty heart.
- `spr(n, x, y)` draws a single 8×8 sprite. `sspr(sx,sy,w,h,dx,dy,dw,dh)` draws a sub-region of the spritesheet.
- `palt(color, transparent)` controls color transparency. `pal()` resets palette.
- `rnd(n)` returns a random float in [0,n). Use `flr(rnd(n))==0` for a 1-in-n integer chance.
- `sfx(n)` plays a sound effect by index.
- Frame timing uses `frame_count` (global) and `level_frame_count` (per-scene).
- `//` is a valid comment syntax in Pico-8 Lua (same as `--`).

## Entity Pattern
Each entity file typically defines:
- A global table (e.g. `hearts={}`) to hold active instances.
- A `spawn_*` function to create and `add()` an instance to the table.
- An `update_*` function called each frame to move and process logic.
- A `draw_*` function called each frame to render.
- Hitboxes are `{hitbox={{x,y},{x,y}}}` where index 1 is top-left and index 2 is bottom-right.

## Health System
- `leo.max_health=3` — displayed slots are `for i=0,leo.max_health` (4 iterations: 0,1,2,3).
- `leo.health` starts at 4 (full). Valid range is 0–4.
- When capping health restored by a pickup: use `leo.health < leo.max_health+1`.

## Heart Pickup (v0.1.1)
- Hearts spawn at small random chance (1 in 20) when a non-boss enemy is defeated.
- Hearts start slow (`spd=0.1`) and gently accelerate (`accel=0.01` per frame) leftward.
- On collision with Leo, restore 1 HP (capped at max). Despawn off left edge (`x < -8`).
- Lives in `entities/heart.lua`; wired into `scenes/l01s01.lua` (update, draw, reset).

## Adding New Enemies
1. Create `entities/<name>.lua` with the entity pattern above.
2. Add `#include entities\<name>.lua` to `halloweenleo.p8`.
3. Wire `update_*` and `draw_*` calls into the appropriate scene file.
4. Reset the table in `reset_l01()`.
5. Call `check_enemy_col` and/or `check_bull_col` as needed in `update_l01()`.

# Game Project — Wurm-like Block Prototype (Godot 4)

This repository contains a small 3D prototype inspired by the *feel* of Wurm/Minecraft-style interaction:
- A player can walk around in 3D
- The world consists of 1×1×1 blocks on a grid
- The player can remove and place blocks using raycast interaction

## Goals (Vertical Slice)
- Player movement: WASD + mouse look + jump
- Block world: grid-based blocks (Dictionary keyed by Vector3i)
- Interaction:
  - Left click: break targeted block
  - Right click: place a block adjacent to the targeted face
- Basic persistence is a later step (not required for the first playable)

## Project Layout
```

/docs
	SPEC.md
	TASKS.md
	AI_RULES.md
/game
(Godot project lives here)
README.md
.gitignore

```

## How to Run
1. Install **Godot 4.x**
2. Open the project located in `/game`
3. Run the `Main.tscn` scene

## Controls
- WASD: move
- Mouse: look
- Space: jump
- LMB: break block
- RMB: place block
- ESC: release mouse (optional behavior)

## Notes
This is intentionally simple: one Node per block is fine for the prototype.
Chunking / meshing / performance optimizations come later.

## License
MIT (or change if you want)
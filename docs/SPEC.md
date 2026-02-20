# SPEC — Block Prototype (Godot 4)

## 1. World Model
- The world is composed of **blocks** on a **1×1×1 grid**.
- A block occupies an integer cell position: `Vector3i(x, y, z)`.
- The prototype uses a simple in-memory representation:
  - `Dictionary<Vector3i, Node3D>` mapping grid cells to spawned block nodes.

### World Size (Initial)
- Default generation size:
  - `size_x = 32`
  - `size_y = 8`
  - `size_z = 32`

### Initial Terrain
- Flat ground layer at `y = 0`:
  - All cells `(x, 0, z)` for `x in [0..31]`, `z in [0..31]` contain a block.

## 2. Player
- Player is a `CharacterBody3D`.
- Camera is a child of the player.
- Movement:
  - WASD relative to camera/player forward/right
  - Jump on Space
  - Gravity applies when not grounded
- Mouse look:
  - Yaw rotates the player body
  - Pitch rotates the camera (clamped)

## 3. Interaction
- A `RayCast3D` originates from the camera and points forward.
- Max interaction distance: **6 units**.

### Break Block (LMB)
- If raycast hits a block:
  - Remove the block at the hit cell.

### Place Block (RMB)
- If raycast hits a block face:
  - Place a block in the adjacent cell in the direction of the hit normal.
  - Example: hit a block on its +X face → place at `(hit_cell.x + 1, hit_cell.y, hit_cell.z)`.
- Placement only occurs if the target cell is empty.

## 4. Non-Goals (for this slice)
- No crafting, skills, stamina, networking, creatures, or economy.
- No advanced terrain meshing/chunking yet.
- No inventory system needed for the first playable.

## 5. Quality Bar
- Must be playable at 60 FPS on a normal desktop for the small default world.
- Code should be readable and modular:
  - `Player` script for movement + interaction calls
  - `BlockWorld` script for world state + spawn/remove blocks
# TASKS — Block Prototype (Godot 4)

## Milestone 1: First Playable (Walk + Place/Break)
- [ ] T01: Create Godot 4 project inside `/game`
- [ ] T02: Setup `Main.tscn` scene structure (Main, BlockWorld, Player, Camera, RayCast)
- [ ] T03: Add input map actions:
  - move_forward, move_back, move_left, move_right, jump
  - break_block (LMB), place_block (RMB)
- [ ] T04: Implement player movement + mouse look + jump (`CharacterBody3D`)
- [ ] T05: Create `block.tscn` (StaticBody3D + MeshInstance3D + CollisionShape3D)
- [ ] T06: Implement `BlockWorld`:
  - Dictionary<Vector3i, Node3D> storage
  - generate flat ground (32×32 at y=0)
  - place/remove functions
- [ ] T07: Implement raycast interaction:
  - LMB break targeted block
  - RMB place adjacent block based on hit normal
- [ ] T08: Add simple crosshair UI (optional)

## Milestone 2: Persistence (Optional)
- [ ] T09: Save world blocks to JSON
- [ ] T10: Load world blocks from JSON on start
- [ ] T11: Add "Reset World" debug key (optional)

## Milestone 3: Performance/Scale (Later)
- [ ] T12: Chunk system (e.g., 16×16×16)
- [ ] T13: MultiMesh or greedy meshing (render optimization)
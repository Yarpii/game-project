# AI_RULES — How Codex Works In This Repo

These rules exist to keep the project clean, predictable, and easy to review.
If any rule conflicts with `/docs/SPEC.md`, SPEC wins.

---

## 1) Scope & Task Discipline
- Work on **exactly ONE task** from `/docs/TASKS.md` per change set.
- Start each change by stating:
  - which task you are implementing (e.g. `T06`)
  - which files you will modify/create
- Do **not** implement “nice extras” unless the task explicitly asks for them.

## 2) No Surprise Refactors
- Do not refactor unrelated code.
- Do not rename files, nodes, scenes, variables, or folders unless required by the task.
- If a refactor is truly needed, propose it briefly and stop.

## 3) Keep Changes Small and Reviewable
- Prefer small, incremental commits.
- Avoid large multi-file rewrites.
- Keep each script focused:
  - `player.gd` = movement + input + interaction calls
  - `block_world.gd` = world state + place/remove + generation
- Avoid “framework” abstractions unless requested.

## 4) Godot Project Rules (Godot 4)
- Godot project lives in `/game`.
- Use **GDScript** unless the repo explicitly switches to C#.
- Scenes:
  - `Main.tscn` should remain the entry scene.
  - `block.tscn` is the block prefab.
- Prefer exporting references over brittle `get_node()` calls:
  - Use `@export var world_path: NodePath` or `@export var world: Node` (as appropriate).
- Do not add plugins or external assets without explicit instruction.

## 5) Coding Style
- Keep code readable over clever.
- Use clear names: `place_block`, `remove_block`, `has_block`.
- Add short comments only where something is non-obvious.
- Handle edge cases cleanly (null checks, bounds checks where relevant).
- No dead code, no commented-out blocks left behind.

## 6) Determinism & World Rules
- The world grid uses `Vector3i` for block coordinates.
- `BlockWorld` is the single source of truth for blocks.
- Player interaction must call `BlockWorld` functions (no direct node deletion outside BlockWorld).

## 7) Input & Controls
- Use Input Map actions defined in TASKS/SPEC.
- Do not hardcode keys in scripts (except ESC for mouse release if needed).
- Interaction distance should follow SPEC (default 6 units).

## 8) Performance Rules (For Now)
- This prototype is allowed to spawn one Node per block.
- Do not implement chunking, greedy meshing, MultiMesh, or optimization unless a task asks for it.

## 9) Testing & Debugging
- If you add debug keys or prints:
  - keep them minimal
  - remove or guard them before completing the task
- If a bug is found, fix it within the same task scope only.

## 10) Deliverables Checklist (Each Task)
Before marking a task as done, ensure:
- The project runs
- The relevant scene loads without errors
- No missing references in the inspector
- No console spam/errors on play

---

## 11) Output Format (When Reporting Back)
When you finish a task, report:
- Task ID completed
- Files changed/added
- How to verify (steps)
- Any known limitations
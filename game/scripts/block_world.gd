extends Node3D

@export var block_scene: PackedScene
@export var size_x: int = 32
@export var size_y: int = 8
@export var size_z: int = 32

var blocks: Dictionary = {}

func _ready() -> void:
	generate_flat_ground()

func has_block(cell: Vector3i) -> bool:
	return blocks.has(cell)

func place_block(cell: Vector3i) -> bool:
	if has_block(cell):
		return false
	if block_scene == null:
		return false

	var block: Node3D = block_scene.instantiate()
	block.position = Vector3(cell.x, cell.y, cell.z)
	add_child(block)
	blocks[cell] = block
	return true

func remove_block(cell: Vector3i) -> bool:
	if not has_block(cell):
		return false

	var block: Node3D = blocks[cell]
	blocks.erase(cell)
	block.queue_free()
	return true

func generate_flat_ground() -> void:
	for x in size_x:
		for z in size_z:
			place_block(Vector3i(x, 0, z))

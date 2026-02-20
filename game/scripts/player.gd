extends CharacterBody3D

const SPEED := 5.0
const JUMP_VELOCITY := 4.5
const MOUSE_SENSITIVITY := 0.002
const MAX_PITCH := deg_to_rad(89.0)
const INTERACTION_DISTANCE := 6.0

@export var world_path: NodePath

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var pitch: float = 0.0

@onready var camera: Camera3D = $Camera
@onready var raycast: RayCast3D = $Camera/RayCast
@onready var world: BlockWorld = get_node_or_null(world_path) as BlockWorld

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	raycast.enabled = true
	raycast.target_position = Vector3(0.0, 0.0, -INTERACTION_DISTANCE)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		pitch = clamp(pitch - event.relative.y * MOUSE_SENSITIVITY, -MAX_PITCH, MAX_PITCH)
		camera.rotation.x = pitch

	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	if event is InputEventMouseButton and event.pressed and Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		return

	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		return

	if event.is_action_pressed("break_block"):
		break_targeted_block()

	if event.is_action_pressed("place_block"):
		place_adjacent_block()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_vector := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var move_direction := (transform.basis * Vector3(input_vector.x, 0.0, input_vector.y)).normalized()

	if move_direction:
		velocity.x = move_direction.x * SPEED
		velocity.z = move_direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0.0, SPEED)
		velocity.z = move_toward(velocity.z, 0.0, SPEED)

	move_and_slide()

func break_targeted_block() -> void:
	if world == null:
		return

	raycast.force_raycast_update()
	if not raycast.is_colliding():
		return

	var hit_point: Vector3 = raycast.get_collision_point()
	var hit_normal: Vector3 = raycast.get_collision_normal()
	var hit_cell := world_to_cell(hit_point - hit_normal * 0.01)
	world.remove_block(hit_cell)

func place_adjacent_block() -> void:
	if world == null:
		return

	raycast.force_raycast_update()
	if not raycast.is_colliding():
		return

	var hit_point: Vector3 = raycast.get_collision_point()
	var hit_normal: Vector3 = raycast.get_collision_normal()
	var target_cell := world_to_cell(hit_point + hit_normal * 0.01)
	world.place_block(target_cell)

func world_to_cell(world_position: Vector3) -> Vector3i:
	return Vector3i(floori(world_position.x), floori(world_position.y), floori(world_position.z))

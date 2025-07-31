extends RigidBody3D

@export var fall_speed = 2.0
@export var max_tilt_degrees = 30.0
@export var tilt_speed: float = 5.0
@export var max_movement_speed = 8.0
@export var tilt_to_movement_factor = 1.0
@export var previous_block_y: Variant = null
@export var minimum_allowed_y: Variant = null
@onready var ground_ray: RayCast3D = $GroundRay

var is_landed := false
var debug_control := false
var spawner: Node = null 
var current_tilt := Vector3.ZERO
var target_tilt := Vector3.ZERO
var rider_position := Vector2.ZERO
var has_checked_platform_height := false
var is_frozen := false

func _ready():
	gravity_scale = 0
	freeze = true
	ground_ray.enabled = true

func _physics_process(delta):
	if is_frozen:
		return
		
	if not has_checked_platform_height and previous_block_y != null:
		if global_position.y < float(previous_block_y):
			has_checked_platform_height = true
			print("block dropped below previous one")
			if spawner and is_instance_valid(spawner):
				spawner._platform_not_placed()
	
	if minimum_allowed_y != null: # to make a min allowed y for the first one
		if global_position.y < float(minimum_allowed_y):
			if not has_checked_platform_height:
				has_checked_platform_height = true
				print("blocked dropped below first one")
				if spawner and is_instance_valid(spawner):
					spawner._platform_not_placed()
	if is_landed:
		return
	global_position.y -= fall_speed * delta
	
	if debug_control:
		handle_debug_input(delta)
	
	apply_tilt(delta)
	apply_tilt_based_movement(delta)
	
	if ground_ray.is_colliding():
		land()

func land():
	if is_landed:
		return
	
	is_landed = true
	gravity_scale = 1
	freeze = false
	debug_control = false
	
	target_tilt = Vector3.ZERO
	rider_position = Vector2.ZERO
	
	print("landed :3")
	if spawner and is_instance_valid(spawner) and spawner.is_inside_tree():
		spawner.spawn_block()

func handle_debug_input(delta):
	var input_dir := Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		input_dir.x += 1
	if Input.is_action_pressed("ui_left"):
		input_dir.x -= 1
	if Input.is_action_pressed("ui_up"):
		input_dir.y -= 1 
	if Input.is_action_pressed("ui_down"):
		input_dir.y += 1 
	
	set_rider_position(input_dir)

func set_rider_position(input_direction: Vector2):
	var move_speed := 2.0 
	
	if input_direction != Vector2.ZERO:
		rider_position += input_direction * move_speed * get_physics_process_delta_time()
		rider_position = rider_position.limit_length(1.0) 
	else:
		rider_position = rider_position.move_toward(Vector2.ZERO, move_speed * get_physics_process_delta_time())
	
	update_tilt_from_rider()

func update_tilt_from_rider():
	var max_tilt_rad = deg_to_rad(max_tilt_degrees)
	target_tilt.z = -rider_position.x * max_tilt_rad 
	target_tilt.x = rider_position.y * max_tilt_rad

func apply_tilt(delta):
	current_tilt = current_tilt.lerp(target_tilt, tilt_speed * delta)
	rotation = current_tilt

func apply_tilt_based_movement(delta):
	var movement := Vector3.ZERO
	
	var tilt_strength = current_tilt.length() / deg_to_rad(max_tilt_degrees)
	var movement_speed = max_movement_speed * tilt_strength * tilt_to_movement_factor
	
	movement.x = -current_tilt.z / deg_to_rad(max_tilt_degrees) 
	movement.z = current_tilt.x / deg_to_rad(max_tilt_degrees) 
	
	if movement.length() > 0:
		global_position += movement * movement_speed * delta
	return rider_position

func move_rider_to(target_pos: Vector2, speed: float = 2.0):
	rider_position = rider_position.move_toward(target_pos.limit_length(1.0), speed * get_physics_process_delta_time())
	update_tilt_from_rider()

func set_rider_position_direct(pos: Vector2):
	rider_position = pos.limit_length(1.0)
	update_tilt_from_rider()

func freeze_platform():
	is_frozen = true
	freeze = true

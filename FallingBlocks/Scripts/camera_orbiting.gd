extends Camera3D

@export var target: Node3D
@export var distance: float = 10.0
@export var height: float = 5.0
@export var speed: float = 1.0
@export var auto_rotate: bool = true

var angle: float = 0.0
var target_pos: Vector3

func _ready():
	if target:
		target_pos = target.global_position

func _process(delta):
	if not target:
		return
	
	if target_pos != target.global_position:
		target_pos = target_pos.lerp(target.global_position, 5.0 * delta)
	
	if auto_rotate:
		angle += speed * delta
	
	var x = cos(angle) * distance
	var z = sin(angle) * distance
	global_position = target_pos + Vector3(x, height, z)
	look_at(target_pos, Vector3.UP)

func stop():
	auto_rotate = false

func start():
	auto_rotate = true

func set_speed(new_speed: float):
	speed = new_speed

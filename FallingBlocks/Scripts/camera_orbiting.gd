extends Camera3D

@export var target_pos: Vector3
@export var distance: float = 10.0
@export var height: float = 5.0
@export var offsetHeight: float = 0.5
@export var speed: float = 1.0
@export var rotationSpeed: float = 0.15
@export var auto_rotate: bool = true

var angle: float = 0.0
var currentTargetPos: Vector3 = Vector3.ZERO

func _ready() -> void:
	SignalBus.Change3DCameraTarget.connect(changeTarget)

func _process(delta):
	if auto_rotate:
		angle += rotationSpeed * delta
	
	var x = cos(angle) * distance
	var z = sin(angle) * distance
	currentTargetPos = currentTargetPos.lerp(target_pos, delta * speed)
	global_position = currentTargetPos + Vector3(x, height + offsetHeight , z)
	look_at(currentTargetPos + Vector3(0, offsetHeight, 0), Vector3.UP)

func changeTarget(body : Node3D = null) -> void:
	if body:
		target_pos = body.global_position

func stop():
	auto_rotate = false

func start():
	auto_rotate = true

func set_speed(new_speed: float):
	speed = new_speed

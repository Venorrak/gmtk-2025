extends RigidBody3D

@export var fall_speed = 2.0
@export var fastDropSpeed : float = 4
@export var max_tilt_degrees = 30.0
@export var tilt_speed: float = 5.0
@export var max_movement_speed = 8.0
@export var landedColor : Color

var is_landed := false
var current_tilt := Vector3.ZERO
var fastDrop : bool = false

func _ready():
	gravity_scale = 0
	body_entered.connect(land)
	SignalBus.fastDropPlatform.connect(_fastDrop)
	SignalBus.stopFastDrop.connect(_normalDrop)

func _physics_process(delta):
	if is_landed:
		return
	linear_velocity = Vector3(-SignalBus.tiltDirection.x * max_movement_speed, -fall_speed, -SignalBus.tiltDirection.y * max_movement_speed)
	if fastDrop:
		linear_velocity.y = -fastDropSpeed
	apply_tilt(delta)

func _fastDrop() -> void:
	fastDrop = true

func _normalDrop() -> void:
	fastDrop = false

func land(body : Node):
	if body.is_in_group("Mountain"):
		print("GAMEOVER")
		SignalBus.Change3DCameraTarget.emit(self)
		SignalBus.gameOver.emit()
		return
	if is_landed:
		return
	SignalBus.Change3DCameraTarget.emit(self)	
	SignalBus.platformDone.emit()
	SignalBus.score += 1
	var material : StandardMaterial3D = $mesh.material_override as StandardMaterial3D
	material.albedo_color = landedColor
	print("LANDED")
	
	is_landed = true
	gravity_scale = 1


func apply_tilt(delta):
	current_tilt = current_tilt.lerp(Vector3(-SignalBus.tiltDirection.y, 0, SignalBus.tiltDirection.x) * deg_to_rad(max_tilt_degrees), tilt_speed * delta)
	rotation = current_tilt

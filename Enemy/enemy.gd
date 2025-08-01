class_name Enemy extends RigidBody2D

@export var Guns : Array[PackedScene]
var startGlobalPosition : Vector2 = Vector2.ZERO

var currentGun = null

func _ready() -> void:
	reset()
	startGlobalPosition = global_position

func resetPosition() -> void:
	global_position = startGlobalPosition

func reset() -> void:
	if currentGun:
		currentGun.queue_free()
	currentGun = Guns.pick_random().instantiate()
	add_child(currentGun)

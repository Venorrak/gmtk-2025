class_name Enemy extends Node2D

@export var Guns : Array[PackedScene]

var currentGun = null

func _ready() -> void:
	reset()

func reset() -> void:
	if currentGun:
		currentGun.queue_free()
	currentGun = Guns.pick_random().instantiate()
	add_child(currentGun)

class_name AnimationBase extends Control

signal gameHidden
signal animEnd

@export var Animator : AnimationPlayer

func _ready() -> void:
	Animator.play("start")

func queue_end() -> void:
	animEnd.emit()
	queue_free()

func signalGameHidden() -> void:
	gameHidden.emit()

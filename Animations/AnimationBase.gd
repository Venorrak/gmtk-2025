class_name AnimationBase
extends Control

@export var Animator : AnimationPlayer

signal gameHidden
signal animEnd

func _ready() -> void:
	Animator.play("start")

func queue_end() -> void:
	animEnd.emit()
	queue_free()

func signalGameHidden() -> void:
	gameHidden.emit()

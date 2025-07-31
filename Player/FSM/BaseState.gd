extends Node
class_name BaseState

# Signal pour annoncer un changement d’état
signal Transitioned
@export var body: Node2D

func handle_attack() -> void:
	pass

func handle_inputs(delta: float) -> void:
	pass

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass

func enter() -> void:
	pass

func exit() -> void:
	pass

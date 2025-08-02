class_name DeathState extends BaseState

@export var animated_sprite: AnimatedSprite2D

func handle_inputs(delta: float) -> void:
	pass

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass

func enter() -> void:
	animated_sprite.play("death")

func exit() -> void:
	pass

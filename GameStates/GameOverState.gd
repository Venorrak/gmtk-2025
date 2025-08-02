class_name GameOverState extends BaseState

@export var endAnimation : PackedScene

func handle_inputs(delta: float) -> void:
	pass

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass

func enter() -> void:
	body.HUD.add_child(endAnimation.instantiate())

func exit() -> void:
	pass

class_name IdleState extends BaseState

func handle_attack() -> void:
	Transitioned.emit(self, "StunnedState")

func handle_inputs(delta: float) -> void:
	var axis : Vector2 = Input.get_vector("left", "right", "up", "down")
	if axis.length() > 0:
		Transitioned.emit(self, "WalkingState")

func update(delta: float) -> void:
	handle_inputs(delta)
	pass

func physics_update(delta: float) -> void:
	pass

func enter() -> void:
	pass

func exit() -> void:
	pass

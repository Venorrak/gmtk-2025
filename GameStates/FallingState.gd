class_name FallingState extends BaseState

func handle_inputs(delta: float) -> void:
	pass

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass

func enter() -> void:
	SignalBus.platformDone.connect(stoppedFalling)
	SignalBus.gameOver.connect(gameOver)
	
func exit() -> void:
	SignalBus.platformDone.disconnect(stoppedFalling)
	SignalBus.gameOver.disconnect(gameOver)

func stoppedFalling() -> void:
	Transitioned.emit(self, "InterState")

func gameOver() -> void:
	Transitioned.emit(self, "GameOverState")

class_name InterState extends BaseState

@export var nbTypesOfPlatforms : int
@export var interAnimScene : PackedScene
var anim

func handle_inputs(delta: float) -> void:
	pass

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass

func enter() -> void:
	anim = interAnimScene.instantiate()
	anim.animEnd.connect(drop)
	anim.gameHidden.connect(screenCovered)
	body.HUD.add_child(anim)
	SignalBus.gameOver.connect(gameOver)

func exit() -> void:
	SignalBus.gameOver.disconnect(gameOver)

func screenCovered() -> void:
	SignalBus.newPlatfrom.emit(randi_range(0, nbTypesOfPlatforms - 1))

func drop() -> void:
	SignalBus.dropPlatform.emit()
	Transitioned.emit(self, "FallingState")

func gameOver() -> void:
	Transitioned.emit(self, "GameOverState")

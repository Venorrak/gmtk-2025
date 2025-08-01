class_name StartState extends BaseState

@export var starAnimScene : PackedScene
var anim

func handle_inputs(delta: float) -> void:
	pass

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass

func enter() -> void:
	anim = starAnimScene.instantiate()
	anim.animEnd.connect(animEnd)
	body.HUD.add_child(anim)
	SignalBus.newPlatfrom.emit(0)

func exit() -> void:
	pass

func animEnd() -> void:
	Transitioned.emit(self, "FallingState")
	SignalBus.dropPlatform.emit()

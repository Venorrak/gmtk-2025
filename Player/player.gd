class_name Player extends RigidBody2D

@export var SM : StateMachine
@onready var collision = $CollisionShape2D
var lastDodgeTime : float = 0 

func _ready() -> void:
	SignalBus.platformDone.connect(refreeze)
	SignalBus.dropPlatform.connect(unFreeze)
	SignalBus.gameOver.connect(death)

func apply_attack() -> void:
	SM.current_state.handle_attack()

func refreeze() -> void:
	freeze = true
	
func unFreeze() -> void:
	freeze = false

func death() -> void:
	SM.on_child_transition(null, "DeathState")

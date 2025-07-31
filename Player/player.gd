class_name Player extends RigidBody2D

@export var SM : StateMachine
@onready var collision = $CollisionShape2D
var lastDodgeTime : float = 0 

func apply_attack() -> void:
	SM.current_state.handle_attack()

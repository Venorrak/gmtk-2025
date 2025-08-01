class_name StateMachine extends Node

@export var initial_state : BaseState
var current_state : BaseState
var states : Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is BaseState:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	
	if initial_state :
		current_state = initial_state
		current_state.enter()
	
func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

# Fonction pour changer d'état
func on_child_transition(state, new_state_name):
	#if state != current_state:
		#return
	var new_state = states.get(new_state_name.to_lower())
	
	if !new_state:
		return
		
	if current_state:
		current_state.exit()
		
	new_state.enter()
	current_state = new_state
	
func initiate() -> void:
	initial_state.enter()

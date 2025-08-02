class_name WalkingState extends BaseState

@export var speed : float = 1000
@export var dodgeDelay : float = 0.5
var animation_tree: AnimationTree
@export var animated_sprite: AnimatedSprite2D
@export var animation_player: AnimationPlayer

func handle_attack() -> void:
	Transitioned.emit(self, "StunnedState")

func handle_inputs(delta: float) -> void:
	var axis : Vector2 = Input.get_vector("left", "right", "up", "down")
	if axis.length() == 0:
		Transitioned.emit(self, "IdleState")
	if Input.is_action_just_pressed("dodge") && (Time.get_ticks_msec() - body.lastDodgeTime) > dodgeDelay * 1000:
		Transitioned.emit(self, "DodgeState")
	body.apply_impulse(axis * speed * delta)

func update(delta: float) -> void:
	handle_inputs(delta)
	pass

func physics_update(delta: float) -> void:
	pass

func enter() -> void:
	animated_sprite.play("walking")
	animation_player.play("walk_bounce")



func exit() -> void:
	animation_player.stop()

class_name StunnedState extends BaseState

@export var speed : float = 1000
@export var stunTime : float
var timer : Timer 
var animation_tree
@export var animated_sprite: AnimatedSprite2D
@export var animation_player: AnimationPlayer

func _ready() -> void:
	var newTimer : Timer = Timer.new()
	newTimer.wait_time = stunTime
	newTimer.one_shot = true
	newTimer.timeout.connect(stunFinished)
	timer = newTimer
	add_child(timer)

func handle_attack() -> void:
	pass

func handle_inputs(delta: float) -> void:
	var axis : Vector2 = Input.get_vector("left", "right", "up", "down")
	body.apply_impulse(axis * speed * delta)

func update(delta: float) -> void:
	handle_inputs(delta)
	pass

func physics_update(delta: float) -> void:
	pass

func enter() -> void:
	timer.start()
	animated_sprite.play("stunned")
	animation_player.play("stunned")




func exit() -> void:
	animation_player.stop()

func stunFinished() -> void:
	Transitioned.emit(self, "IdleState")
	pass

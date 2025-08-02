class_name DodgeState extends BaseState

@export var dodgeSpeed : float = 1500
@export var dodgeTime : float
var timer : Timer
var dodgeDirection : Vector2 = Vector2.ZERO
@export var animated_sprite: AnimatedSprite2D

func _ready() -> void:
	var newTimer : Timer = Timer.new()
	newTimer.wait_time = dodgeTime
	newTimer.one_shot = true
	newTimer.timeout.connect(dodgeFinished)
	timer = newTimer
	add_child(timer)

func handle_attack() -> void:
	pass

func handle_inputs(delta: float) -> void:
	pass

func update(delta: float) -> void:
	body.apply_impulse(dodgeDirection * dodgeSpeed * delta)

func physics_update(delta: float) -> void:
	pass

func enter() -> void:
	timer.start()
	dodgeDirection = Input.get_vector("left", "right", "up", "down")
	body.collision.set_deferred("disabled", true)
	animated_sprite.play("dodge")

func exit() -> void:
	body.collision.set_deferred("disabled", false)
	body.lastDodgeTime = Time.get_ticks_msec()

func dodgeFinished() -> void:
	Transitioned.emit(self, "IdleState")

class_name StunnedState extends BaseState

@export var speed : float = 1000
@export var stunTime : float
var timer : Timer 

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

func exit() -> void:
	pass

func stunFinished() -> void:
	Transitioned.emit(self, "IdleState")
	pass

class_name Gun extends Node2D

@export var nbCannons : int = 1
@export_range(1, 360, 0.1) var angle : float
@export var cone : bool = false
@export var cooldown : float = 0.5
@export var rotationSpeed : float = 0
@export var radius : float = 100
@export var detectionRadius : float = 200
var canShoot : bool = true
var timer : Timer = Timer.new()
var cannons : Array[Node2D] = []
var target = null

@export var bullet : PackedScene

func _ready() -> void:
	timer.wait_time = cooldown
	timer.one_shot = true
	timer.timeout.connect(_timerCallback)
	add_child(timer)
	setupCannons()
	setupDetector()
	

func setupDetector() -> void:
	var newArea = Area2D.new()
	var newCollision = CollisionShape2D.new()
	var newShape = CircleShape2D.new()
	newShape.radius = detectionRadius
	newCollision.shape = newShape
	newArea.add_child(newCollision)
	add_child(newArea)
	newArea.body_entered.connect(_bodyEntered)
	newArea.body_exited.connect(_bodyExited)

func setupCannons() -> void:
	var step : float
	if cone:
		step = deg_to_rad(angle) / (nbCannons - 1)
	else:
		step = deg_to_rad(angle) / nbCannons
		
	for i in nbCannons:
		var spawnPoint : Node2D = Node2D.new()
		var pos : Vector2 = Vector2(radius, 0).rotated(step * i)
		spawnPoint.position = pos
		spawnPoint.rotation = pos.angle()
		add_child(spawnPoint)
		cannons.append(spawnPoint)

func _process(delta: float) -> void:
	if rotationSpeed == 0 and target:
		rotation = (target.global_position - global_position).angle() - (deg_to_rad(angle / 2.0))
	else:
		rotation_degrees += rotationSpeed * delta
	if target:
		shoot(bullet)

func _draw() -> void:
	draw_circle(position, detectionRadius, Color.RED, false, 3)

func shoot(bullet : PackedScene) -> void:
	if canShoot:
		for s in cannons:
			var dubBullet = bullet.instantiate()
			get_tree().root.add_child(dubBullet)
			dubBullet.position = s.global_position
			dubBullet.rotation = s.global_rotation
		canShoot = false
		timer.start()
	
func can_shoot() -> bool:
	return canShoot

func _timerCallback() -> void:
	canShoot = true

func _bodyEntered(body : Node2D) -> void:
	if body.is_in_group("player"):
		target = body

func _bodyExited(body : Node2D) -> void:
	if body.is_in_group("player"):
		target = null 

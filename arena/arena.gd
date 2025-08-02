extends Node2D

@export var nbEnnemies : int = 30
@export var minSpawnRadius : float = 200
@export var maxSpawnRadius : float = 1000
@export var ennemySpacing : float = 100
var spawningAttempts = 10

@export var arenaCenter : Vector2 = Vector2.ZERO
@export var platformSpeed : float = 100
@export var curve : Curve

@export var ennemyScene : PackedScene
@export var walls : Array[PackedScene]
@export var player : RigidBody2D
@export var powerLabel : Label

var ennemies : Array[RigidBody2D] = []
var currentWall : Node2D

func _draw() -> void:
	draw_line(arenaCenter, player.position, Color.WHITE)

func _physics_process(delta: float) -> void:
	var deltaPlayerCenter : Vector2 = arenaCenter - player.position
	var speedProportion : Vector2 = Vector2(curve.sample(abs(deltaPlayerCenter.x)), curve.sample(abs(deltaPlayerCenter.y))).limit_length()
	speedProportion.x *= -1 if deltaPlayerCenter.x < 0 else 1
	speedProportion.y *= -1 if deltaPlayerCenter.y < 0 else 1
	SignalBus.tiltDirection = speedProportion
	applyMovementToEnnemies(speedProportion * platformSpeed)
	powerLabel.text = str(round(speedProportion.length() * 100)) + "%"
	queue_redraw()

func _ready() -> void:
	spawnEnnemies()
	player.position = arenaCenter
	SignalBus.newPlatfrom.connect(reset)


func reset(wallIndex : int) -> void:
	if currentWall:
		currentWall.queue_free()
	currentWall = walls[wallIndex].instantiate()
	currentWall.position += arenaCenter
	add_child(currentWall)
	player.position = arenaCenter
	resetEnnemies()
	clearBullets()

func applyMovementToEnnemies(movement : Vector2) -> void:
	for e in ennemies:
		e.linear_velocity = movement

func spawnEnnemies() -> void:
	for i in nbEnnemies:
		var newPosition = getSpawnPosition()
		if newPosition:
			var newEnnemy = ennemyScene.instantiate()
			newEnnemy.position = newPosition
			ennemies.append(newEnnemy)
			newEnnemy.visible = false
			add_child(newEnnemy)

func getSpawnPosition() -> Variant:
	for i in spawningAttempts:
		var pos = Vector2(randf_range(-maxSpawnRadius, maxSpawnRadius), randf_range(-maxSpawnRadius, maxSpawnRadius))
		var d = pos.distance_to(arenaCenter)
		if d > minSpawnRadius and d < maxSpawnRadius and spacingCorrect(pos):
			return pos
	return null

func spacingCorrect(pos : Vector2) -> bool:
	for e in ennemies:
		if pos.distance_to(e.position) < ennemySpacing:
			return false
	return true

func resetEnnemies() -> void:
	for i in ennemies:
		i.resetPosition()

func clearBullets() -> void:
	for b in get_parent().get_children():
		if b is Bullet:
			b.queue_free()

extends Node2D

@export var nbEnnemies : int = 30
@export var spawnRadius : float = 600
@export var arenaCenter : Vector2 = Vector2.ZERO
@export var player : RigidBody2D
@export var platformSpeed : float = 100

@export var ennemyScene : PackedScene

var ennemies : Array[Node2D] = []

func _physics_process(delta: float) -> void:
	var deltaPlayerCenter : Vector2 = (arenaCenter - player.position).limit_length()
	print(deltaPlayerCenter)
	applyMovementToEnnemies(deltaPlayerCenter * platformSpeed * delta)

func _ready() -> void:
	spawnEnnemies()
	player.position = arenaCenter
	pass

func applyMovementToEnnemies(movement : Vector2) -> void:
	for e in ennemies:
		e.position += movement

func spawnEnnemies() -> void:
	for i in nbEnnemies:
		var newEnnemy = ennemyScene.instantiate()
		newEnnemy.position = Vector2(randf_range(-spawnRadius, spawnRadius), randf_range(-spawnRadius, spawnRadius)) + arenaCenter
		ennemies.append(newEnnemy)
		add_child(newEnnemy)

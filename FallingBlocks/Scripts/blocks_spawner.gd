extends Node3D

@export var block_scenes: Array[PackedScene]
@export var active_platforms_count: int = 10
@export var heightFromTheHighestOne: float = 15
@export var radiusSpawn : float = 5

var current_block: RigidBody3D = null
var spawned_blocks: Array[Node3D] = []
var currentBlockIndex : int = 0

func _ready():
	SignalBus.newPlatfrom.connect(changeIndex)
	SignalBus.dropPlatform.connect(spawn_block)
	SignalBus.gameOver.connect(freezeAll)

func changeIndex(index : int) -> void:
	currentBlockIndex = index

func spawn_block():
	if block_scenes.is_empty():
		return
		
	var block = block_scenes[currentBlockIndex]
	var new_block = block.instantiate()
	new_block.global_position = Vector3(randf_range(2, radiusSpawn), getHighestPoint() + heightFromTheHighestOne, 0)
	new_block.position = new_block.position.rotated(Vector3(0, 1, 0), randf_range(deg_to_rad(0), deg_to_rad(360)))
	print(new_block.global_rotation)

	get_parent().add_child(new_block)
	current_block = new_block
	spawned_blocks.append(new_block)

	var freeze_index = spawned_blocks.size() - active_platforms_count - 1
	if freeze_index >= 0:
		spawned_blocks[freeze_index].freeze = true

func getHighestPoint() -> float:
	var highest: float = 0
	for b in spawned_blocks:
		if b.global_position.y > highest:
			highest = b.global_position.y
	return highest

func freezeAll() -> void:
	for b in spawned_blocks:
		b.freeze = true

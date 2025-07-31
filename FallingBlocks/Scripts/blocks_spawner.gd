extends Node3D

@export var block_scenes: Array[PackedScene]
@export var minimum_allowed_y = -10.0
@export var active_platforms_count: int = 3

var current_block: RigidBody3D = null
var spawned_blocks: Array[Node3D] = []

func _ready():
	print("spawner ready")
	call_deferred("spawn_block")

func spawn_block():
	if block_scenes.is_empty():
		return
	print("spawn block")
	
	if not is_inside_tree():
		print("spawner not in tree")
		return
		
	var random_block = block_scenes[randi() % block_scenes.size()]
	var new_block = random_block.instantiate()
	
	if spawned_blocks.size() > 0:
		var previous_y = spawned_blocks[-1].global_position.y
		print("assigning previous_block_y ", previous_y)
		new_block.set("previous_block_y", previous_y)
	else:
		print("assigning previous_block_y (start) ", minimum_allowed_y)
		new_block.set("previous_block_y", minimum_allowed_y)

	call_deferred("_deferred_spawn_block", new_block)

func _deferred_spawn_block(new_block):
	if not is_inside_tree():
		if new_block:
			new_block.queue_free()
		return
	
	if not get_tree() or not get_tree().current_scene:
		if new_block:
			new_block.queue_free()
		return
	
	new_block.global_position = global_position
	new_block.set("spawner", self)
	new_block.set("debug_control", true)
	new_block.set("minimum_allowed_y", minimum_allowed_y)

	get_tree().current_scene.add_child(new_block)
	
	current_block = new_block
	spawned_blocks.append(new_block)

	var freeze_limit = spawned_blocks.size() - active_platforms_count - 1
	for i in range(freeze_limit + 1):
		var old_platform = spawned_blocks[i]
		if old_platform and old_platform.is_inside_tree():
			if old_platform.has_method("freeze_platform"):
				old_platform.freeze_platform()
			elif old_platform is RigidBody3D:
				old_platform.mode = 1



func _platform_not_placed():
	print("platform lower than the previous one")

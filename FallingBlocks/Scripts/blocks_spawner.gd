extends Node3D

@export var block_scenes: Array[PackedScene]
var current_block: RigidBody3D = null

func _ready():
	call_deferred("spawn_block")

func spawn_block():
	if block_scenes.is_empty():
		return
	
	if not is_inside_tree():
		print("spawner not in tree")
		return
		
	var random_block = block_scenes[randi() % block_scenes.size()]
	var new_block = random_block.instantiate()
	
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
	get_tree().current_scene.add_child(new_block)
	current_block = new_block

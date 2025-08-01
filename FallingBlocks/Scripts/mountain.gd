extends MeshInstance3D

func _ready() -> void:
	create_convex_collision()
	var body = $Mountain_col
	body.add_to_group("Mountain")

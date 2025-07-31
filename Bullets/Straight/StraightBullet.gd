class_name StraightBullet extends Bullet

func _process(delta: float) -> void:
	position += transform.x * speed * delta
	lifetime -= delta
	if lifetime < 0:
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.apply_attack()
		queue_free()

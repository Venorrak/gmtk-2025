class_name WavyBullet extends Bullet
var currentLifetime : float = 0
@export_range(0, 1, 0.01) var amplitude : float = 1
@export var freq : float = 7

func _ready() -> void:
	currentLifetime = lifetime

func _process(delta: float) -> void:
	position += transform.x.rotated(sin((lifetime - currentLifetime) * freq) * amplitude) * speed * delta
	currentLifetime -= delta
	if currentLifetime < 0:
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.apply_attack()
		queue_free()

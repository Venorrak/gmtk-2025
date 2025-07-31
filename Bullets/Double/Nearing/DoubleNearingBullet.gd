class_name DoubleNearingBullet extends Bullet
var currentLifetime : float = 0
@export var spacing : float = 80
@export var freq : float = 4

@onready var bullet1 = $Bullet1
@onready var bullet2 = $Bullet2

func _ready() -> void:
	currentLifetime = lifetime

func _process(delta: float) -> void:
	position += transform.x * speed * delta
	currentLifetime -= delta
	var status : float = sin((lifetime - currentLifetime) * freq)
	bullet1.position.y = (-spacing / 2) * status
	bullet2.position.y = (spacing / 2) * status
	if currentLifetime < 0:
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.apply_attack()
		queue_free()

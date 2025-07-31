class_name DoubleRotateBullet extends Bullet
var currentLifetime : float = 0
@export var spacing : float = 40
@export var rotationSpeed : float = 4

@onready var bullet1 = $Pivot/Bullet1
@onready var bullet2 = $Pivot/Bullet2

func _ready() -> void:
	currentLifetime = lifetime
	bullet1.position.y = -spacing / 2
	bullet2.position.y = spacing / 2

func _process(delta: float) -> void:
	position += transform.x * speed * delta
	currentLifetime -= delta
	$Pivot.rotation = currentLifetime * rotationSpeed
	if currentLifetime < 0:
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.apply_attack()
		queue_free()

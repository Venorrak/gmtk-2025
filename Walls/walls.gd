class_name Walls extends Node2D

@export var zone : Area2D

func _ready() -> void:
	zone.body_entered.connect(body_entered)
	zone.body_exited.connect(body_exited)
	zone.area_entered.connect(area_entered)
	zone.area_exited.connect(area_exited)
	
func body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.visible = true

func body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.visible = false

func area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.get_parent().visible = false
		
func area_exited(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.get_parent().visible = true

extends Node

@onready var animationp: AnimationPlayer = $"."

func startanimation(): 
	animationp.play("startanimation")
	
func toggle_time():
	get_tree().paused = !get_tree().paused

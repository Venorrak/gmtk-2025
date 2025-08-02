class_name EndAnimation extends AnimationBase

@export var gameOverScreen : PackedScene

func goToGameOver() -> void:
	get_tree().change_scene_to_packed(gameOverScreen)

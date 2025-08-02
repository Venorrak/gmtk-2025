extends Control

@export var Animator : AnimationPlayer
@export var scoreLabel : Label
@export var restartButton : TextureButton
@export var menuScene : PackedScene
@export var gameScene : PackedScene

func _ready() -> void:
	Animator.play("start")
	scoreLabel.text = "Your Score is : " + str(SignalBus.score)
	SignalBus.score = 0
	restartButton.grab_focus()

func _on_restart_button_up() -> void:
	#get_tree().change_scene_to_packed(gameScene)
	pass

func _on_menu_button_up() -> void:
	#get_tree().change_scene_to_packed(menuScene)
	pass

extends Control

@export var Animator : AnimationPlayer
@export var scoreLabel : Label
@export var restartButton : TextureButton
@export var menuScene : PackedScene
@export var gameScene : PackedScene
@export var buttonSound : AudioStream

func _ready() -> void:
	Animator.play("start")
	scoreLabel.text = "Your Score is : " + str(SignalBus.score)
	SignalBus.score = 0
	restartButton.grab_focus()

func _on_restart_button_up() -> void:
	playButtonSound()
	get_tree().change_scene_to_packed(gameScene)

func _on_menu_button_up() -> void:
	playButtonSound()
	get_tree().change_scene_to_packed(menuScene)
	
func playButtonSound() -> void:
	AudioManager.playSound(buttonSound)

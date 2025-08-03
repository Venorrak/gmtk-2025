extends Control

@onready var main_buttons = $MainButtons
@onready var panel_settings = $PanelSettings
@export var backButton : TextureButton
@export var buttonSound : AudioStream
@export var mainScene : PackedScene

func _ready():
	main_buttons.visible = true
	panel_settings.visible = false
	if main_buttons:
		main_buttons.get_child(0).grab_focus()
	$AnimationPlayer.play("mountains")

func _on_start_button_up() -> void:
	playButtonSound()
	get_tree().change_scene_to_packed(mainScene)

func _on_settings_button_up() -> void:
	playButtonSound()
	main_buttons.visible = false
	panel_settings.visible = true
	backButton.grab_focus()

func _on_exit_button_up() -> void:
	playButtonSound()
	get_tree().quit()

func _on_back_button_up() -> void:
	playButtonSound()
	_ready()
	
func playButtonSound() -> void:
	AudioManager.playSound(buttonSound)

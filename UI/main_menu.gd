extends Control

@onready var main_buttons = $MainButtons
@onready var panel_settings = $PanelSettings
@export var backButton : TextureButton

func _ready():
	main_buttons.visible = true
	panel_settings.visible = false
	main_buttons.get_child(0).grab_focus()
	$AnimationPlayer.play("mountains")

func _on_start_button_up() -> void:
	get_tree().change_scene_to_file("res://main.tscn")

func _on_settings_button_up() -> void:
	main_buttons.visible = false
	panel_settings.visible = true
	backButton.grab_focus()

func _on_exit_button_up() -> void:
	get_tree().quit()

func _on_back_button_up() -> void:
	_ready()

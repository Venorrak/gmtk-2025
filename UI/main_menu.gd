extends Control

@onready var main_buttons = $MainButtons
@onready var panel_settings = $PanelSettings

func _ready():
	main_buttons.visible = true
	panel_settings.visible = false

func _on_start_pressed():
	get_tree().change_scene_to_file("res://main.tscn")

func _on_settings_pressed():
	main_buttons.visible = false
	panel_settings.visible = true


func _on_exit_pressed():
	get_tree().quit()


func _on_back_pressed():
	_ready()

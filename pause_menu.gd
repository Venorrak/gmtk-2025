extends Control

@onready var pause = $"."
@onready var main_buttons = $MainButtons
@export var menuScene : PackedScene

var inPauseMenu := false
var pausedTime = false

func _ready():
	pause.visible = false

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		inPauseMenu = !inPauseMenu
		pause.visible = inPauseMenu
		if inPauseMenu and !pausedTime:
			toggleTime()
			
		elif pausedTime:
			toggleTime()


func _on_exit_pressed():
	get_tree().quit()

func toggleTime():
	if Engine.time_scale == 0.0:
		Engine.time_scale = 1.0 
	else:
		Engine.time_scale = 0.0
		$PanelSettings/HSlider.grab_focus()
		pausedTime = inPauseMenu

func _on_quit_button_up() -> void:
	get_tree().quit()

func _on_restart_button_up() -> void:
	SignalBus.score = 0
	get_tree().reload_current_scene()

func _on_menu_button_up() -> void:
	SignalBus.score = 0
	get_tree().change_scene_to_packed(menuScene)

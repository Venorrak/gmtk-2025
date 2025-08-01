extends Control

@onready var pause = $"."
@onready var main_buttons = $MainButtons

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
		pausedTime = inPauseMenu

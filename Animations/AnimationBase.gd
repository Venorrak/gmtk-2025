class_name AnimationBase extends Control

signal gameHidden
signal animEnd

@export var bg_animator : AnimationPlayer
@export var text_animator : AnimationPlayer

@export var bgtimer: Timer
@export var texttimer: Timer
@export var typewriter_timer: Timer  

@export var label: RichTextLabel
@export var typewriter_speed := 0.05  

@export var phrases : Array[String] = []

var current_phrase_index := 0
var char_index := 0
var typing := false
var current_phrase := ""

func _ready() -> void:
	bgtimer.timeout.connect(bganimation)
	typewriter_timer.timeout.connect(typewriterTimeout)
	typewriter_timer.wait_time = typewriter_speed

	bg_animator.play("start")
	bg_animator.play("background")



func bganimation():
	text_animator.play("textbg")
	texttimer.timeout.connect(texttimerTimeout)
	texttimer.start() 
	

func texttimerTimeout():
	if current_phrase_index >= phrases.size():
		texttimer.stop() 
		return

	current_phrase = phrases[current_phrase_index]
	current_phrase_index += 1

	char_index = 0
	label.clear()
	typing = true
	typewriter_timer.start()

	
func typewriterTimeout():
	if not typing:
		typewriter_timer.stop()
		return

	if char_index <= current_phrase.length():
		label.text = current_phrase.substr(0, char_index)
		char_index += 1
	else:
		typewriter_timer.stop()
		typing = false
		texttimer.start()  



func queue_end() -> void:
	animEnd.emit()
	queue_free()

func signalGameHidden() -> void:
	gameHidden.emit()

func textAppear():
	text_animator.play("textbg")

func timerTimeout():
	textAppear()

class_name StartingAnimation
extends AnimationBase

@export var bg_animator : AnimationPlayer
@export var text_animator : AnimationPlayer

@export var bgtimer: Timer
@export var phrase_timer: Timer
@export var typewriter_timer: Timer

@export var label: RichTextLabel
@export var typewriter_speed := 0.05  

@export var phrases : Array[String] = []
@export var phrase_durations : Array[float] = []

var current_phrase_index := 0
var char_index := 0
var typing := false
var current_phrase := ""
var phrase_being_typed := -1
var animationPlayed = false 

func _ready() -> void:
	bgtimer.timeout.connect(bganimation)
	typewriter_timer.timeout.connect(typewriterTimeout)
	typewriter_timer.wait_time = typewriter_speed
	
	bg_animator.play("start")
	bg_animator.play("background")

func _process(delta):
	if current_phrase_index == 8 && !animationPlayed:
		bg_animator.play("fadeout")
		animationPlayed = true

func bganimation():
	text_animator.play("textbg")
	phrase_timer.timeout.connect(_on_phrase_timer_timeout)
	start_next_phrase()
	

func start_next_phrase():
	if current_phrase_index >= phrases.size():
		phrase_timer.stop()
		return
	
	current_phrase = phrases[current_phrase_index]
	char_index = 0
	label.clear()
	typing = true
	typewriter_timer.start()
	
	print("starting phrase ", current_phrase_index, " ", current_phrase)

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
		
		var duration = 2.0
		if phrase_durations.size() > current_phrase_index:
			duration = phrase_durations[current_phrase_index]
		
		current_phrase_index += 1  
		phrase_timer.start(duration)

func _on_phrase_timer_timeout():
	start_next_phrase()


func queue_end() -> void:
	animEnd.emit()
	queue_free()


func signalGameHidden() -> void:
	gameHidden.emit()


func textAppear():
	text_animator.play("textbg")


func timerTimeout():
	textAppear()

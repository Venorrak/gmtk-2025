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
var animationScreenshotPlayed = false 

func _ready() -> void:
	bgtimer.timeout.connect(bganimation)
	typewriter_timer.timeout.connect(typewriterTimeout)
	typewriter_timer.wait_time = typewriter_speed
	
	bg_animator.play("start")
	bg_animator.play("background")

func _process(delta):
	if current_phrase_index == 6 and !animationPlayed:
		bg_animator.play("fadeout")
		animationPlayed = true
	if current_phrase_index == 4 and !animationScreenshotPlayed:
		text_animator.play("screenshot")
		animationScreenshotPlayed = true

	if Input.is_action_just_pressed("skipcutscene"):
		skip_cutscene()


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

func skip_cutscene() -> void:
	bgtimer.stop()
	phrase_timer.stop()
	typewriter_timer.stop()
	bg_animator.play("fadeout") 
	
	if typing and current_phrase_index < phrases.size():
		label.text = phrases[current_phrase_index]
		typing = false

	current_phrase_index = phrases.size()
	bg_animator.stop()
	text_animator.stop()
	bg_animator.play("fadeout") 
	queue_end()

# sorry
func textcountdown1():
	$RichTextLabel2.text = "1"
func textcountdown2():
	$RichTextLabel2.text = "2"
func textcountdown3():
	$RichTextLabel2.text = "3"

func cleartext():
	label.text = ""

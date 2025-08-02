class_name GameManager extends Node2D

@export var SM : StateMachine
@export var HUD : CanvasLayer
@export var scoreLabel : Label

func _ready() -> void:
	SignalBus.platformDone.connect(checkScore)

func checkScore() -> void:
	scoreLabel.text = "Score : " + str(SignalBus.score)

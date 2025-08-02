extends Node2D

@export var sprites: Array[Texture2D] = []
@onready var sprite_to_change = $Sprite2D

var color_options: Array[Color] = [
	Color.RED, 
	Color.GREEN,
	Color.LIGHT_BLUE
] # to change to something more vaporwave hackerman typa ting badabing hey im walking here

func _ready():
	var random_sprite = sprites.pick_random()
	sprite_to_change.texture = random_sprite
	sprite_to_change.modulate = color_options.pick_random()

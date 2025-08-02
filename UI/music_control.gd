class_name MusicVolumeSlider extends HSlider

@export var audio_bus_name: String = "Music"

var audio_bus_id

func _ready():
	audio_bus_id = AudioServer.get_bus_index(audio_bus_name)
	max_value = 1.0
	step = 0.01
	value = db_to_linear(AudioServer.get_bus_volume_db(audio_bus_id))
	
func _on_value_changed(value: float) -> void:
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(audio_bus_id, db)

extends Node

var audioPLayers : Array = []
@export var musics : Array[AudioStream] = []
func _ready() -> void:
	$MusicPlayer.stream = musics.pick_random()
	$MusicPlayer.play()

func playSound(sound : AudioStream) -> void:
	var newAudioPlayer = AudioStreamPlayer.new()
	newAudioPlayer.stream = sound
	newAudioPlayer.bus = "SFX"
	audioPLayers.append(newAudioPlayer)
	add_child(newAudioPlayer)
	newAudioPlayer.play()

func _on_timer_timeout() -> void:
	for i in audioPLayers.size():
		if not audioPLayers[i].playing:
			audioPLayers[i].queue_free()
			audioPLayers.remove_at(i)
			break

func _on_music_player_finished() -> void:
	$MusicPlayer.stream = musics.pick_random()
	$MusicPlayer.play()

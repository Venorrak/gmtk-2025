extends AnimationBase

@export var interSound : AudioStream

func playSound() -> void:
	AudioManager.playSound(interSound)

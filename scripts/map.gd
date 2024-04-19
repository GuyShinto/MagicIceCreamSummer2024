extends Node2D


func _ready():
	AudioManager.die.stop()
	AudioManager.into.stop()
	AudioManager.music_bg.play()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

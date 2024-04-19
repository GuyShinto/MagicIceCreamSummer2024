extends CanvasLayer

@onready var list := $"Label"

#var listV:Vector2

#var time:float

func _ready():
	get_tree().paused = false
	AudioManager.into.stop()
	AudioManager.music_bg.stop()
	AudioManager.die.play()
	#listV = list.position
	pass
	
func _process(delta):
	list.position.y -= delta*50

func _input(event):
	if event is InputEventKey:
		if Input.is_action_pressed("restart"):
			ChangeScene.Restart()

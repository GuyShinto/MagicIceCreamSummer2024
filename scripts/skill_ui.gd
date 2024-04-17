extends CanvasLayer

@onready var anim:AnimationPlayer = $"animation"

func _ready():
	anim.play("skill")
	pass

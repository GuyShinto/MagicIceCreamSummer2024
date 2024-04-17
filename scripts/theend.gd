extends CanvasLayer

@onready var list := $"Label"

#var listV:Vector2

#var time:float

func _ready():
	#listV = list.position
	pass
	
func _process(delta):
	list.position.y -= delta*50

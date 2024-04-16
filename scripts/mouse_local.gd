extends Marker2D

@onready var area :Area2D = $"area"

var list:Array

func _ready():
	Global.mouse = self
	area.body_entered.connect(_entered)
	area.body_exited.connect(_exited)

func _physics_process(_delta):
	global_position = get_global_mouse_position()

func _entered(_body):
	if not(_body in list):
		list.append(_body)
func _exited(_body):
	if (_body in list):
		list.erase(_body)

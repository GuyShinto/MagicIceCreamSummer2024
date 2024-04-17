extends Marker2D

@onready var area :Area2D = $"area"
@onready var area_long :Area2D = $"area_long"

var list:Array
var listl:Array

func _ready():
	Global.mouse = self
	area.body_entered.connect(_entered)
	area.body_exited.connect(_exited)
	area_long.body_entered.connect(_enteredl)
	area_long.body_exited.connect(_exitedl)

func _physics_process(_delta):
	global_position = get_global_mouse_position()

func _outlist(_body):
	list.erase(_body)
	listl.erase(_body)

func _entered(_body):
	if not(_body in list):
		list.append(_body)
func _exited(_body):
	if (_body in list):
		list.erase(_body)

func _enteredl(_body):
	if not(_body in list):
		listl.append(_body)
func _exitedl(_body):
	if (_body in list):
		listl.erase(_body)

extends Node

@export var offset:Vector2
@export var ices:int = 10

@onready var main := $".."

var isOver : bool

var ice := preload("res://scenes/objects/ice.tscn")

func _ready():
	if main.has_node("open"):
		main.get_node("open").mouse_entered.connect(_entered)
		main.get_node("open").mouse_exited.connect(_exited)

func _spawn_ice(ran):
	for i in range(1,randi_range(1,ran)):
		var ins = ice.instantiate()
		ins.global_position = main.global_position + offset
		Global.objects.add_child(ins)

func _entered():
	isOver = true
func _exited():
	isOver = false

func _input(event):
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("left_click"):
			if isOver and main.freeze:
				_spawn_ice(ices)
				main.freeze = false
				

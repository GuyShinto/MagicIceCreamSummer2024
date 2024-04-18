extends Node

@onready var main := $".."

@export var damge:float = 1
@export var hitMax:float = 500

func _ready():
	if main is RigidBody2D:
		main.contact_monitor = true
		main.max_contacts_reported = 1
		main.body_shape_entered.connect(_entered)
func _entered(_rid, _body, _body_index, _local_index):
	if (abs(main.linear_velocity.x) > hitMax or abs(main.linear_velocity.y) > hitMax):
		#if _body is RigidBody2D:
		#	_body.freeze = false
		if _body.is_in_group("player") or _body.is_in_group("enemy"):
			_body.get_node("object")._take_damge(damge)

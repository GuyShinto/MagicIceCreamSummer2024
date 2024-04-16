extends Node

@onready var main := $".."

@export var canFreeze : bool = true

func _process(delta):
	if (Global.despawn_y <= main.position.y):
		main.queue_free()

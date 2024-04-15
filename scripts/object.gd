extends Node

@onready var main := $".."

@export var electrical : bool = false
@export var cooly : float = 1.0
@export var canFreeze : bool = true

func _process(delta):
	if (Global.despawn_y <= main.position.y):
		main.queue_free()

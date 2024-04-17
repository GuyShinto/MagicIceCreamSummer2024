extends Node

@onready var main := $".."

@export var canFreeze : bool = true

func _process(_delta):
	if (Global.despawn_y <= main.position.y):
		Global.mouse._outlist(self)
		Global.temperature.cold.erase(self)
		Global.temperature.cooly.erase(self)
		main.queue_free()

extends Node

@onready var area:Area2D= $"area"



func _ready():
	area.body_entered.connect(_entered)
	area.body_exited.connect(_exited)

func _entered(_body):
	for ice in Global.temperature.cold:
		if ice.is_in_group("ice"):
			Global.temperature.cold.append(ice)
func _exited(_body):
	for ice in Global.temperature.cold:
		if ice.is_in_group("ice"):
			Global.temperature.cold.erase(ice)

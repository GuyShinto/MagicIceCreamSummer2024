extends Node2D

@onready var _text := $"text"

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			_text.visible = false
			ChangeScene.Change("res://scenes/map.tscn")

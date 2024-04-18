extends Node

@onready var main := $".."

var water_object := preload("res://scenes/objects/water.tscn")
var speed:float = 20
var fromshoot:Marker2D
var toshoot:Marker2D

func _ready():
	if main.has_node("from_shoot"):
		fromshoot = main.get_node("from_shoot")
	if main.has_node("to_shoot"):
		toshoot = main.get_node("to_shoot")

func _shoot(ran:int = 1):
	for i in range(1,randi_range(1,ran)):
		var water = water_object.instantiate()
		water.global_position = fromshoot.global_position
		water.linear_velocity = Vector2(toshoot.global_position.x-fromshoot.global_position.x,toshoot.global_position.y-fromshoot.global_position.y)*speed
		Global.water.add_child(water)

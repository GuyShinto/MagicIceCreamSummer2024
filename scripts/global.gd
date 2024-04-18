extends Node

var despawn_y : float = 10000

var water:Node2D
var rewards:Panel
var player:RigidBody2D
var mouse:Marker2D
var camera:Camera2D
var ui:CanvasLayer
var temperature:Panel
var cursor:TextureRect
var items:Array[IceCream]

var theend := preload("res://scenes/theend.tscn")

func _ready():
	water = get_tree().get_first_node_in_group("water_group")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _get_end():
	get_tree().current_scene.add_child(theend.instantiate())

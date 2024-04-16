extends Node

var despawn_y : float = 1000

var rewards:Panel
var player:RigidBody2D
var mouse:Marker2D
var camera:Camera2D
var ui:CanvasLayer
var temperature:Panel
var cursor:TextureRect
var items:Array[IceCream]

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

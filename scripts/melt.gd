extends Node

@onready var main := $".."
@onready var collision := $"../collision"
@onready var timer := $"timer"

@export var max_malt :float = 10

var baseScale :Vector2 = Vector2(1,1)
var baseMass :float

var water := preload("res://scenes/objects/water.tscn")

func _ready():
	if main is RigidBody2D:
		baseMass = main.mass
	timer.wait_time = max_malt
	timer.timeout.connect(_on_timeout)
	timer.start()

func _physics_process(_delta):
	if main is RigidBody2D:
		main.mass = clamp(baseMass * (timer.time_left/max_malt),1,100)
	main.scale = clamp(baseScale * (timer.time_left/max_malt),baseScale*0.1,baseScale)
	collision.scale = clamp(baseScale * (timer.time_left/max_malt),baseScale*0.1,baseScale)

func _on_timeout():
	timer.stop()
	Global.mouse._outlist(self)
	Global.temperature.cold.erase(self)
	_spawn_water(5)
	main.queue_free()

func _spawn_water(ran):
	for i in range(1,randi_range(1,ran)):
		var ins = water.instantiate()
		ins.global_position = main.global_position + Vector2(randf_range(-1,1),randf_range(-1,1))
		Global.water.add_child(ins)

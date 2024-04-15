extends Node

@onready var main := $".."
@onready var collision := $"../collision"
@onready var timer := $"timer"

@export var max_malt :float = 10

var baseScale :Vector2 = Vector2(1,1)

func _ready():
	timer.wait_time = max_malt
	timer.timeout.connect(_on_timeout)
	timer.start()

func _physics_process(_delta):
	main.scale = clamp(baseScale * (timer.time_left/max_malt),baseScale*0.1,baseScale)
	collision.scale = clamp(baseScale * (timer.time_left/max_malt),baseScale*0.1,baseScale)

func _on_timeout():
	timer.stop()
	main.queue_free()

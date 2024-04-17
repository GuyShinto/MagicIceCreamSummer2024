extends Node

@onready var timer :Timer = $"timer"
@onready var main := $".."

@export var canFreeze : bool = true
@export var cpBarLocal : Vector2
@export var maxCp : float = 60
@export var maltcp:float = 1

var showtime:float = 2.5
var cpbar = null
var cool_material = null
var cp :float

func _ready():
	if canFreeze and main.has_node("cpbar"):
		cpbar = main.get_node("cpbar")
		cool_material = main.get_node("icon")
		cool_material.material = load("res://shaders/freeze_material.tres")
		cpbar.max_value = maxCp
		timer.timeout.connect(_on_timeout)
		timer.start()

func SetFade(alpha:float):
	cpbar.modulate.a = sin(alpha)

func _show():
	var tween = create_tween()
	tween.tween_method(SetFade, cpbar.modulate.a, PI, showtime).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)

func _add_cool(_value):
	if canFreeze:
		cp = clamp(cp+_value,0,maxCp*2)
		if cp > 0:
			timer.start()
			_show()
			_highcool()

func _on_timeout():
	if cp <= 0:
		timer.stop()
		_lowcool()
	else:
		timer.start()
		cp -= maltcp
		_highcool()

func _lowcool():
	#main.get_node("icon").texture = electricalOff
	pass

func _highcool():
	cpbar.value = cp
	cool_material.material.set_shader_parameter("cool",clamp(cp/maxCp,0.0,1.0))
	if cp >= maxCp:
		#frezze
		pass
	#main.get_node("icon").texture = electricalOn
	pass

func _process(_delta):
	if (Global.despawn_y <= main.position.y):
		Global.mouse._outlist(self)
		Global.temperature.cold.erase(self)
		Global.temperature.cooly.erase(self)
		main.queue_free()

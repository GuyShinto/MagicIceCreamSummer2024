extends Node

@onready var timer :Timer = $"timer"
@onready var main := $".."

#@export var canContact : bool = true
@export var canFreeze : bool = true
@export var maxHp:float = 30
@export var maxCp : float = 60
@export var maltcp:float = 1

var hasHp:bool
var showtime:float = 2.5
var cpbar = null
var hpbar = null
var cool_material = null
var cp :float
var hp : float
var frezze : bool

var BaseFriction:float = 1.0

func _ready():
	#if canContact:
	#	if main is RigidBody2D:
	#		main.contact_monitor = true
	#		main.max_contacts_reported = 1
	if main is RigidBody2D:
		if not main.physics_material_override:
			main.physics_material_override = PhysicsMaterial.new()
			BaseFriction = main.physics_material_override.friction
		else:
			BaseFriction = main.physics_material_override.friction
	if main.has_node("hpbar"):
		hasHp = true
		hpbar = main.get_node("hpbar")
		hp = maxHp
		hpbar.value = maxHp
		hpbar.max_value = maxHp
	if canFreeze and main.has_node("cpbar"):
		cpbar = main.get_node("cpbar")
		cool_material = main.get_node("icon")
		cool_material.material = load("res://shaders/freeze_material.tres").duplicate()
		cpbar.max_value = maxCp
		timer.timeout.connect(_on_timeout)
		timer.start()

func SetFadeC(alpha:float):
	cpbar.modulate.a = sin(alpha)

func SetFadeH(alpha:float):
	hpbar.modulate.a = sin(alpha)

func _show_cp():
	var tween = create_tween()
	tween.tween_method(SetFadeC, cpbar.modulate.a, PI, showtime).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
func _show_hp():
	var tween = create_tween()
	tween.tween_method(SetFadeH, hpbar.modulate.a, PI, showtime).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)

func _add_cool(_value):
	if canFreeze:
		cp = clamp(cp+_value,0,maxCp*2)
		if cp > 0:
			timer.start()
			_show_cp()
			_highcool()

func _take_damge(_value):
	if hasHp:
		hp = clamp(hp-_value,0,maxHp)
		hpbar.value = hp
		if _value > 0:
			_show_hp()

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
	var fcp:float = clamp(cp/maxCp,0.0,1.0)
	main.physics_material_override.friction = clamp(BaseFriction-fcp,0.0,1.0)
	cool_material.material.set_shader_parameter("cool",fcp)
	if cp >= maxCp:
		frezze=true
	else:
		frezze=false
	#main.get_node("icon").texture = electricalOn
	#pass



func _process(_delta):
	if (Global.despawn_y <= main.position.y) or (hasHp and hp <= 0):
		Global.mouse._outlist(self)
		Global.temperature.cold.erase(self)
		Global.temperature.cooly.erase(self)
		if main == Global.player:
			if not Global.player.OnDie:
				Global._get_end()
				Global.player.OnDie = true
		else:
			main.queue_free()

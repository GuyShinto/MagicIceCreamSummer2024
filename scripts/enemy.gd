extends RigidBody2D

@onready var area:Area2D = $"area"
@onready var idle:Sprite2D = $"icon"
@onready var attack:Node2D = $"attack"
@onready var attack_up:Sprite2D = $"attack/up"
@onready var attack_down:Sprite2D = $"attack/down"
@onready var attack_highlight:Sprite2D = $"attack/highlight"
@onready var attack_to:Marker2D = $"attack/up/to"
@onready var attack_from:Marker2D = $"attack/up/from"
@onready var timer:Timer = $"timer"
@onready var object:Node = $"object"

var water_object := preload("res://scenes/objects/water.tscn")
var speed:float = 20

var time:float
var BaseS:Vector2
var BaseSUP:Vector2
var BaseSDOWN:Vector2

func _ready():
	NotHasTarget()
	BaseS = idle.scale
	BaseSUP = attack_up.scale
	BaseSDOWN = attack_down.scale
	area.area_entered.connect(_entered)
	area.area_exited.connect(_exited)
	timer.timeout.connect(_timeout)

func _timeout():
	attack_highlight.material = idle.material
	attack_down.material = idle.material
	attack_up.material = idle.material
	if attack.visible and not object.frezze:
		_shoot(2)

func _shoot(ran:int = 1):
	for i in range(1,randi_range(1,ran)):
		var water = water_object.instantiate()
		water.global_position = attack_from.global_position
		water.linear_velocity = Vector2(attack_to.global_position.x-attack_from.global_position.x,attack_to.global_position.y-attack_from.global_position.y)*speed
		Global.water.add_child(water)

func _physics_process(_delta):
	if not object.frezze:
		if time < TAU:
			time += _delta*4
		else:
			time = 0.0
		idle.scale.y = BaseS.y + sin(time)*0.01
		attack.scale.y = 1 + sin(time)*0.08
		if Global.player:
			if Global.player.global_position.x-self.global_position.x > 0:
				idle.scale.x = -BaseS.x
				attack_up.scale.x = -BaseSUP.x
				attack_down.scale.x = -BaseSDOWN.x
				attack_highlight.scale.x = -BaseSDOWN.x
				attack_up.look_at(Global.player.global_position)
				attack_highlight.rotation = attack_up.rotation
			else:
				idle.scale.x = BaseS.x
				attack_up.scale.x = BaseSUP.x
				attack_down.scale.x = BaseSDOWN.x
				attack_highlight.scale.x = BaseSDOWN.x
				attack_up.look_at(Global.player.global_position)
				attack_up.rotation += 3.0
				attack_highlight.rotation = attack_up.rotation

func _entered(_area):
	if _area.is_in_group("player"):
		if not object.frezze:
			HasTarget()
func _exited(_area):
	if _area.is_in_group("player"):
		if not object.frezze:
			NotHasTarget()
func HasTarget():
	idle.visible = false
	attack.visible = true
func NotHasTarget():
	idle.visible = true
	attack.visible = false

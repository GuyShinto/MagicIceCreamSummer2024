extends RigidBody2D

@onready var area:Area2D = $"area"
@onready var idle:Sprite2D = $"idle"
@onready var attack:Node2D = $"attack"
@onready var attack_up:Sprite2D = $"attack/up"
@onready var attack_highlight:Sprite2D = $"attack/highlight"

var time:float
var BaseS:Vector2

func _ready():
	HasTarget()
	BaseS = idle.scale
	area.area_entered.connect(_entered)
	area.area_exited.connect(_exited)

func _physics_process(_delta):
	if time < TAU:
		time += _delta*4
	else:
		time = 0.0
	idle.scale.y = BaseS.y + sin(time)*0.01
	attack.scale.y = 1 + sin(time)*0.08
	if Global.player:
		#fixed this 
		attack_up.look_at(Global.player.global_position)

func _entered(_area):
	if _area.is_in_group("player"):
		HasTarget()
func _exited(_area):
	if _area.is_in_group("player"):
		NotHasTarget()
func HasTarget():
	idle.visible = false
	attack.visible = true
func NotHasTarget():
	idle.visible = true
	attack.visible = false

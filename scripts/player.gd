extends RigidBody2D

@export var speed = 50
@export var atMalt = 10
@export var hairNormal:Texture2D
@export var hairMalt:Texture2D

@export var eyeIdle:Texture2D
@export var eyeMove:Texture2D
@export var eyeDying:Texture2D
@export var eyeDie:Texture2D

@export var hot:Texture2D
@export var cold:Texture2D

@onready var textbox:TextureRect= $"textbox"
@onready var textboxicon:TextureRect= $"textbox/icon"
@onready var area:Area2D= $"area"
@onready var eye:Sprite2D= $"face/eye"
@onready var hair:Sprite2D= $"face/hair"
@onready var object:Node = $"object"
@onready var timer:Timer = $"timer"

var OnDie:bool
var heatShow:float
var maxHeatShow:float = 30

func _ready():
	Global.player = self
	area.body_entered.connect(_entered)
	area.body_exited.connect(_exited)
	timer.timeout.connect(_timeout)

func _timeout():
	var _cold = Global.temperature.heat/20
	if global_rotation < -2.0 or global_rotation > 2.0:
		object._take_damge(1 + _cold)
	if Global.temperature.heat > atMalt:
		AudioManager.malt.play()
		object._take_damge(Global.temperature.heat/10)
		_show_heat(false)
	elif Global.temperature.heat < -atMalt*2:
		_show_heat(true)

func _show_heat(isCold):
	if isCold:
		textboxicon.texture = cold
	else:
		textboxicon.texture = hot
	if heatShow <= 0:
		heatShow = maxHeatShow
		var tween = create_tween()
		tween.tween_method(SetFadeH, textbox.modulate.a, PI, 5).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	else:
		heatShow -= 1

func SetFadeH(alpha:float):
	textbox.modulate.a = sin(alpha)

func _change_hair(_vlaue):
	if _vlaue > atMalt:
		hair.texture = hairMalt
	else:
		hair.texture = hairNormal

func _physics_process(_delta):
	var dis:float = Input.get_axis("left", "right")
	if abs(dis) > 0:
		self.angular_velocity = dis * speed * _delta
	if not OnDie:
		if global_rotation < -2.0 or global_rotation > 2.0:
			eye.texture = eyeDying
		else:
			if abs(dis) > 0:
				eye.texture = eyeMove
				if dis > 0:
					eye.flip_h = false
				else:
					eye.flip_h = true
			else:
				eye.texture = eyeIdle
	else:
		eye.texture = eyeDie

func _entered(_body):
	if _body.is_in_group("ice"):
		Global.temperature.cold.append(_body)
func _exited(_body):
	if _body.is_in_group("ice"):
		Global.temperature.cold.erase(_body)

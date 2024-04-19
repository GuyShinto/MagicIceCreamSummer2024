extends Panel

@onready var indicator :TextureRect = $"indicator"
@onready var indicatorIcon :TextureRect = $"indicator/icon"
@onready var title : Label = $"indicator/icon/title"
@onready var timer :Timer = $"timer"

@export var hoter:float = 0.5;
@export var maxHeat:float = 40;

var icon_cool:Texture2D = preload("res://artwork/indicator_cool.png")
var icon_verycool:Texture2D = preload("res://artwork/indicator_verycool.png")
var icon_hot:Texture2D = preload("res://artwork/indicator_hot.png")
var icon_veryhot:Texture2D = preload("res://artwork/indicator_veryhot.png")

var baseIndicator : Vector2

var heat : float

var cold : Array

var cooly : Array

var coldS : float

func _ready():
	Global.temperature = self
	timer.timeout.connect(_timeout)
	baseIndicator = indicator.position

func _hot(value):
	var tween = get_tree().create_tween()
	tween.tween_method(SetFade, heat, heat+value, 0.3).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	heat += value
	if Global.player:
		Global.player._change_hair(heat)
	Postprocess.SetHeat(heat/maxHeat)
	if (heat > 0):
		if(heat > maxHeat):
			indicatorIcon.texture = icon_veryhot
		else:
			indicatorIcon.texture = icon_hot
	else:
		if(heat < -maxHeat):
			indicatorIcon.texture = icon_verycool
		else:
			indicatorIcon.texture = icon_cool
	title.text = "%s °c" % [round(heat)]

func SetFade(alpha:float):
	indicator.position.y = baseIndicator.y - clamp(alpha,-80,80)

func _timeout():
	_hot(hoter - (cold.size()*0.2) - (sum_cool()) - coldS)

func sum_cool():
	var _sum:float = 0
	for c in cooly:
		_sum += c.cooly
	return _sum

func _physics_process(delta):
	indicatorIcon.position = Vector2() + Vector2(randf()*abs(heat*2),randf()*abs(heat*2)) * delta

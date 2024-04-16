extends Panel

@onready var indicator :TextureRect = $"indicator"
@onready var indicatorIcon :TextureRect = $"indicator/icon"
@onready var title : Label = $"indicator/icon/title"
@onready var timer :Timer = $"timer"

var icon_cool:Texture2D = preload("res://artwork/indicator_cool.png")
var icon_verycool:Texture2D = preload("res://artwork/indicator_verycool.png")
var icon_hot:Texture2D = preload("res://artwork/indicator_hot.png")
var icon_veryhot:Texture2D = preload("res://artwork/indicator_veryhot.png")

var baseIndicator : Vector2

var heat : float = 0

func _ready():
	timer.timeout.connect(_timeout)
	baseIndicator = indicator.position

func _hot(value):
	var tween = get_tree().create_tween()
	tween.tween_method(SetFade, heat, heat+value, 0.3).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	heat += value
	if (heat > 0):
		if(heat > 40):
			indicatorIcon.texture = icon_veryhot
		else:
			indicatorIcon.texture = icon_hot
	else:
		if(heat < -40):
			indicatorIcon.texture = icon_verycool
		else:
			indicatorIcon.texture = icon_cool
	title.text = "%s °c" % [round(heat)]

func SetFade(alpha:float):
	indicator.position.y = baseIndicator.y - clamp(alpha,-80,80)

func _timeout():
	_hot(0.5)

func _physics_process(delta):
	indicatorIcon.position = Vector2() + Vector2(randf()*abs(heat*2),randf()*abs(heat*2)) * delta

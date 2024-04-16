extends Node

@onready var main := $".."

@export var normal:Texture2D
@export var highlight:Texture2D
@export var power:float = 1.05

var onHighlight:bool = false

var time:float = 0

func _ready():
	main.mouse_entered.connect(_entered)
	main.mouse_exited.connect(_exited)
	
func _entered():
	if not onHighlight:
		var tween = create_tween()
		tween.tween_method(SetFade, time, 1.0, 0.3).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
		main.texture = highlight
		onHighlight = true

func _exited():
	if onHighlight:
		var tween = create_tween()
		tween.tween_method(SetFade, time, 0.0, 0.3).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
		main.texture = normal
		onHighlight = false

func SetFade(alpha:float):
	time = alpha
	main.scale = Vector2(1,1) * lerp(1.0,power,alpha)

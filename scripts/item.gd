extends Panel

@onready var icon :TextureRect = $"icon"
@onready var button :Button = $"button"

@export var power:float = 1.05

var id:int
var normal:Texture2D
var highlight:Texture2D

var onHighlight:bool

var time:float = 0

func _ready():
	button.pressed.connect(_pressed)
	self.mouse_entered.connect(_entered)
	self.mouse_exited.connect(_exited)

func _pressed():
	Global.cursor._set_mouse(id)

func _entered():
	if not onHighlight:
		AudioManager.click.play()
		var tween = get_tree().create_tween()
		tween.tween_method(SetFade, time, 1.0, 0.3).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
		icon.texture = highlight
		onHighlight = true

func _exited():
	if onHighlight:
		var tween = get_tree().create_tween()
		tween.tween_method(SetFade, time, 0.0, 0.3).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
		icon.texture = normal
		onHighlight = false

func SetFade(alpha:float):
	time = alpha
	icon.rotation_degrees = sin(alpha*TAU)*(lerp(0.0,25.0,alpha))
	icon.scale = Vector2(1,1) * lerp(1.0,1.3,alpha)

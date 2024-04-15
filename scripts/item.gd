extends Panel

@onready var icon :TextureRect = $"icon"

var time:float = 0

func _ready():
	self.mouse_entered.connect(_entered)
	self.mouse_exited.connect(_exited)
	
func _entered():
	var tween = get_tree().create_tween()
	tween.tween_method(SetFade, time, 1.0, 0.3).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)

func _exited():
	var tween = get_tree().create_tween()
	tween.tween_method(SetFade, time, 0.0, 0.3).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)

func SetFade(alpha:float):
	time = alpha
	icon.rotation_degrees = sin(alpha*TAU)*(lerp(0.0,25.0,alpha))
	icon.scale = Vector2(1,1) * lerp(1.0,1.3,alpha)

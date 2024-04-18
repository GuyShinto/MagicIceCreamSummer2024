extends CanvasLayer

@onready var icon := $"icon"
@onready var broken := $"broken"

var BaseV:Vector2

func _ready():
	BaseV = icon.global_position
	var tween = create_tween()
	tween.tween_method(SetFade, 0.0, 1.0, 0.5).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(0.7).timeout
	AudioManager.broken.play()
	await get_tree().create_timer(0.1).timeout
	broken.visible = true
	var tween1 = create_tween()
	tween1.tween_method(SetFade2, 0.0, 1.0, 0.5).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)

func SetFade(alpha:float):
	icon.position.x = BaseV.x - lerp(0,1200,alpha)
	
func SetFade2(alpha:float):
	broken.scale = Vector2(1,1) * lerp(1.2,1.0,alpha)

extends CanvasLayer

@onready var screen :ShaderMaterial = $"screen".material

func SetRipple(_value):
	screen.set_shader_parameter("local", _value)
	var tween = create_tween()
	tween.tween_method(SetFade, 0.0, 1.0, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func SetFade(alpha:float):
	screen.set_shader_parameter("time", alpha)
	screen.set_shader_parameter("fade", 1.-alpha)

extends CanvasLayer

@onready var Fade:ShaderMaterial = $"fade".material

var delay:float = 1
var changing:bool

func Restart():
	if not changing:
		changing = true
		var tweenFadeIn = create_tween()
		tweenFadeIn.tween_method(set_shader_value, 1., -1.5, delay).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		await get_tree().create_timer(delay).timeout
		
		get_tree().reload_current_scene()
		
		init_shader(true)
		var tweenFadeOut = create_tween()
		tweenFadeOut.tween_method(set_shader_value, 1., -1.5, delay).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		await get_tree().create_timer(delay).timeout
		init_shader(false)
		changing = false

func init_shader(_opposite):
	Fade.set_shader_parameter("position", 1.)
	Fade.set_shader_parameter("opposite", _opposite)

func set_shader_value(value: float):
	Fade.set_shader_parameter("position", value)

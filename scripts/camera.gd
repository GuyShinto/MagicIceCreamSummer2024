extends Camera2D

var zoomer :float= 0.25

var shake_power :float= 10.0
var shake_fade :float= 0.0
var duration :float= 0.1

func _ready():
	Global.camera = self

func _physics_process(_delta):
	if Global.player:
		var target = Global.player
		if is_instance_valid(target):
			if target.is_in_group("player"):
				_follow(target.position,true)
				if shake_fade > 0 and duration > 0:
					_set_shake()
			else:
				_follow(target.c,false)
				if shake_fade > 0 and duration > 0:
					_set_shake()

func _follow(thispos:Vector2,thisplayer:bool):
	if thisplayer:
		var tween_camerafollow = create_tween()
		var half_size = get_viewport_rect().size/2
		tween_camerafollow.tween_property(self, "offset", thispos + (get_viewport().get_mouse_position() - half_size) * zoomer, 2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	else:
		var tween_camerafollow = create_tween()
		var half_size = get_viewport_rect().size/2
		var distance = get_global_mouse_position().distance_to(thispos)
		tween_camerafollow.tween_property(self, "offset", thispos - (get_viewport().get_mouse_position() - half_size) * zoomer * 2 * (distance / 1000), 2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)

func _set_shake():
	var tween_camerashake = create_tween()
	var power = shake_power * shake_fade
	var shake_random = Vector2(randf_range(-1,1) * power,randf_range(-1,1) * power)
	tween_camerashake.tween_property(self, "position", shake_random, duration).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	shake_fade -= 0.1

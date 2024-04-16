extends TextureRect


var speedMosue :float = 0

func _physics_process(delta):
	#if speedMosue > 0.3:
	#	speedMosue -= 0.2
	#elif speedMosue < -0.3:
	#	speedMosue += 0.2
	speedMosue = speedMosue/2
	var tween = get_tree().create_tween()
	tween.tween_method(SetFade, self.rotation, speedMosue, 0.3).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)

func _click():
	var tween = get_tree().create_tween()
	tween.tween_method(SetSize, Vector2(1.0,1.0)*0.9, Vector2(1.0,1.0), 0.5).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)

func _input(event):
	if event is InputEventMouseButton:
		if Input.is_action_pressed("left_click"):
			_click()
		if Input.is_action_pressed("right_click"):
			_click()
	if event is InputEventMouseMotion:
		self.position = get_viewport().get_mouse_position()
		speedMosue += (event.velocity.x/10000) + (-event.velocity.y/10000)

func SetSize(alpha:Vector2):
	self.scale = alpha

func SetFade(alpha:float):
	self.rotation = alpha

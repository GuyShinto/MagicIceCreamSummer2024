extends TextureRect


var speedMosue :float = 0
var indexItem :int = 0

func _ready():
	Global.cursor = self

func _physics_process(_delta):
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

func _set_mouse(_index):
	if Global.items.size():
		if _index <= -1:
			indexItem = Global.items.size()
		elif _index > Global.items.size():
			indexItem = 0
		else:
			indexItem = _index
		self.texture = Global.items[indexItem-1].cursor
		_click()

func _input(event):
	if event is InputEventKey:
		if Input.is_action_pressed("sort1"):
			_set_mouse(1)
		elif Input.is_action_pressed("sort2"):
			_set_mouse(2)
		elif Input.is_action_pressed("sort3"):
			_set_mouse(3)
		elif Input.is_action_pressed("sort4"):
			_set_mouse(4)
		elif Input.is_action_pressed("sort5"):
			_set_mouse(5)
		elif Input.is_action_pressed("sort6"):
			_set_mouse(6)
		elif Input.is_action_pressed("sort7"):
			_set_mouse(7)
		elif Input.is_action_pressed("sort8"):
			_set_mouse(8)
		elif Input.is_action_pressed("sort9"):
			_set_mouse(9)
		elif Input.is_action_pressed("sort0"):
			_set_mouse(10)
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("left_click"):
			_click()
		elif Input.is_action_just_pressed("right_click"):
			_click()
			Global.rewards._show(randi_range(1,2))
		elif Input.is_action_pressed("left_wheel"):
			_set_mouse(indexItem+1)
		elif Input.is_action_pressed("right_wheel"):
			_set_mouse(indexItem-1)
	if event is InputEventMouseMotion:
		self.position = get_viewport().get_mouse_position()
		speedMosue += (event.velocity.x/10000) + (-event.velocity.y/10000)

func SetSize(alpha:Vector2):
	self.scale = alpha

func SetFade(alpha:float):
	self.rotation = alpha

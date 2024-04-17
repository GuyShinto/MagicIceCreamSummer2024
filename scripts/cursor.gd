extends TextureRect

@export var maxIceMove:float = 200

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
	var tween = create_tween()
	tween.tween_method(SetFade, self.rotation, speedMosue, 0.3).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)

func _click():
	var tween = create_tween()
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

func _process(_delta):
	if Input.is_action_pressed("left_click"):
		#_spell4()
		pass
	elif Input.is_action_just_pressed("right_click"):
		_spell()

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
			_spell5()
			#_spell3()
			#_spell()
		elif Input.is_action_just_pressed("right_click"):
			_click()
			Global.rewards._show(randi_range(1,7))
		elif Input.is_action_pressed("left_wheel"):
			_set_mouse(indexItem+1)
		elif Input.is_action_pressed("right_wheel"):
			_set_mouse(indexItem-1)
	if event is InputEventMouseMotion:
		self.position = get_viewport().get_mouse_position()
		speedMosue += (event.velocity.x/10000) + (-event.velocity.y/10000)

func _spell():
	for ice in Global.mouse.list:
		if ice:
			if ice.is_in_group("ice"):
				var mousePostion:Vector2 = Global.mouse.global_position
				ice.linear_velocity = Vector2(clamp(mousePostion.x-ice.global_position.x,-maxIceMove,maxIceMove),clamp(mousePostion.y-ice.global_position.y,-maxIceMove,maxIceMove))

func _spell2():
	for ice in Global.mouse.list:
		if ice:
			if ice.has_node("melt"):
				ice.get_node("melt")._on_timeout()

func _spell3():
	if not get_tree().paused:
		Effects.SetRipple(get_global_mouse_position())

func _spell4():
	for wat in Global.mouse.list:
		if wat:
			if wat.is_in_group("water"):
				var mousePostion:Vector2 = Global.mouse.global_position
				wat.linear_velocity = Vector2(clamp(mousePostion.x-wat.global_position.x,-maxIceMove,maxIceMove),clamp(mousePostion.y-wat.global_position.y,-maxIceMove,maxIceMove))
			
func _spell5():
	if not get_tree().paused:
		Effects.SetRipple(get_global_mouse_position())
	for i in Global.mouse.listl:
		if i:
			if i.is_in_group("water") or i.is_in_group("ice"):
				var mousePostion:Vector2 = Global.mouse.global_position
				i.linear_velocity = -Vector2(1.0,1.0)/(Vector2(clamp(mousePostion.x-i.global_position.x,-maxIceMove,maxIceMove),clamp(mousePostion.y-i.global_position.y,-maxIceMove,maxIceMove))*0.00001)

func SetSize(alpha:Vector2):
	self.scale = alpha

func SetFade(alpha:float):
	self.rotation = alpha

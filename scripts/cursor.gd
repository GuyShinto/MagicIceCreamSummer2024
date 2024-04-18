extends TextureRect

@export var maxIceMove:float = 200

var speedMosue :float
var indexItem :int
var hasSkill :bool
var indexMagic :int

var skillui = preload("res://scenes/skill.tscn")

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
			indexItem = 1
		else:
			indexItem = _index
		var thisItem = Global.items[indexItem-1]
		self.texture = thisItem.cursor
		indexMagic = thisItem.id
		_click()

func _process(_delta):
	if Input.is_action_pressed("left_click"):
		match indexMagic:
			1:
				_spell1()
			2:
				_spell8()
			3:
				_spell3()
			6:
				_spell4()
			5:
				_spell2()
	elif Input.is_action_pressed("right_click"):
		match indexMagic:
			1:
				_spell1long()
			2:
				_spell8()
			3:
				_spell3long()
			6:
				_spell4long()
			5:
				_spell2long()

func _input(event):
	if event is InputEventKey:
		if Input.is_action_pressed("sort1"):
			_skill()
			_set_mouse(1)
		elif Input.is_action_pressed("sort2"):
			ChangeScene.Restart()
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
			match indexMagic:
				1:
					AudioManager.ice1.play()
				2:
					AudioManager.skill1.play()
				3:
					AudioManager.ice4.play()
				4:
					AudioManager.magic3.play()
					_spell5()
				5:
					AudioManager.ice3.play()
				6:
					AudioManager.ice5.play()
				7:
					AudioManager.paralyze1.play()
					_spell6()
		elif Input.is_action_just_pressed("right_click"):
			_click()
			match indexMagic:
				1:
					AudioManager.ice1.play()
				2:
					AudioManager.skill1.play()
				3:
					AudioManager.ice4.play()
				4:
					AudioManager.magic4.play()
					_spell5back()
				5:
					AudioManager.ice3.play()
				6:
					AudioManager.ice5.play()
				7:
					AudioManager.paralyze1.play()
					_spell6long()
			#_skill()
			#AudioManager.reward.play()
		elif Input.is_action_pressed("up_wheel"):
			_set_mouse(indexItem+1)
		elif Input.is_action_pressed("down_wheel"):
			_set_mouse(indexItem-1)
	if event is InputEventMouseMotion:
		self.position = get_viewport().get_mouse_position()
		speedMosue += (event.velocity.x/10000) + (-event.velocity.y/10000)

func _spell1():
	for ice in Global.mouse.list:
		if Global._check_null(ice):
			if ice.is_in_group("ice"):
				var mousePostion:Vector2 = Global.mouse.global_position
				ice.linear_velocity = Vector2(clamp(mousePostion.x-ice.global_position.x,-maxIceMove,maxIceMove),clamp(mousePostion.y-ice.global_position.y,-maxIceMove,maxIceMove))*2

func _spell1long():
	for ice in Global.mouse.listl:
		if Global._check_null(ice):
			if ice.is_in_group("ice"):
				var mousePostion:Vector2 = Global.mouse.global_position
				ice.linear_velocity = Vector2(clamp(mousePostion.x-ice.global_position.x,-maxIceMove,maxIceMove),clamp(mousePostion.y-ice.global_position.y,-maxIceMove,maxIceMove))

func _spell2():
	for ice in Global.mouse.list:
		if Global._check_null(ice):
			if ice.has_node("object"):
				if ice.get_node("object").canFreeze:
					ice.get_node("object")._add_cool(-0.1)
			if ice.has_node("melt"):
				ice.get_node("melt")._on_timeout()

func _spell2long():
	for ice in Global.mouse.listl:
		if Global._check_null(ice):
			if ice.has_node("object"):
				if ice.get_node("object").canFreeze:
					ice.get_node("object")._add_cool(-0.01)

func _spell3():
	for o in Global.mouse.list:
		if Global._check_null(o):
			if o.has_node("object"):
				if o.get_node("object").canFreeze:
					o.get_node("object")._add_cool(0.1)
func _spell3long():
	for o in Global.mouse.listl:
		if Global._check_null(o):
			if o.has_node("object"):
				if o.get_node("object").canFreeze:
					o.get_node("object")._add_cool(0.01)

func _spell4():
	for wat in Global.mouse.list:
		if Global._check_null(wat):
			if wat.is_in_group("water"):
				var mousePostion:Vector2 = Global.mouse.global_position
				wat.linear_velocity = Vector2(clamp(mousePostion.x-wat.global_position.x,-maxIceMove,maxIceMove),clamp(mousePostion.y-wat.global_position.y,-maxIceMove,maxIceMove))*0.5

func _spell8():
	for wat in Global.mouse.list:
		if Global._check_null(wat):
			if wat is RigidBody2D:
				if not(wat.is_in_group("player")):
					var mousePostion:Vector2 = Global.mouse.global_position
					wat.linear_velocity = Vector2(clamp(mousePostion.x-wat.global_position.x,-maxIceMove,maxIceMove),clamp(mousePostion.y-wat.global_position.y,-maxIceMove,maxIceMove))*0.01

func _spell4long():
	for wat in Global.mouse.listl:
		if Global._check_null(wat):
			if wat.is_in_group("water"):
				var mousePostion:Vector2 = Global.mouse.global_position
				wat.linear_velocity = Vector2(clamp(mousePostion.x-wat.global_position.x,-maxIceMove,maxIceMove),clamp(mousePostion.y-wat.global_position.y,-maxIceMove,maxIceMove))
			
func _spell5():
	if not get_tree().paused:
		Effects.SetRipple(get_global_mouse_position())
	for i in Global.mouse.listl:
		if Global._check_null(i):
			if i.is_in_group("water") or i.is_in_group("ice"):
				var mousePostion:Vector2 = Global.mouse.global_position
				i.linear_velocity = -Vector2(1.0,1.0)/(Vector2(clamp(mousePostion.x-i.global_position.x,-maxIceMove,maxIceMove),clamp(mousePostion.y-i.global_position.y,-maxIceMove,maxIceMove))*0.00001)

func _spell5back():
	if not get_tree().paused:
		Effects.SetRipple(get_global_mouse_position())
	for i in Global.mouse.listl:
		if Global._check_null(i):
			if i.is_in_group("water") or i.is_in_group("ice"):
				var mousePostion:Vector2 = Global.mouse.global_position
				i.linear_velocity = Vector2(1.0,1.0)/(Vector2(clamp(mousePostion.x-i.global_position.x,-maxIceMove,maxIceMove),clamp(mousePostion.y-i.global_position.y,-maxIceMove,maxIceMove))*0.00001)


func _spell6():
	for el in Global.mouse.list:
		if Global._check_null(el):
			if el.has_node("electrical"):
				el.get_node("electrical")._add_energy(5)
			if el.is_in_group("watergun"):
				el.get_node("water_gun")._shoot(3)
func _spell6long():
	for el in Global.mouse.listl:
		if Global._check_null(el):
			if el.has_node("electrical"):
				el.get_node("electrical")._add_energy(1)
			if el.is_in_group("watergun"):
				el.get_node("water_gun")._shoot(2)

func _spell7():
	for w in Global.mouse.list:
		if Global._check_null(w):
			if w.is_in_group("watergun"):
				w.get_node("water_gun")._shoot()

func _skill():
	if not hasSkill:
		get_tree().current_scene.add_child(skillui.instantiate())
		hasSkill = true

func SetSize(alpha:Vector2):
	self.scale = alpha

func SetFade(alpha:float):
	self.rotation = alpha

extends CanvasLayer

#@onready var anim:AnimationPlayer = $"animation"
@onready var blur = $"blur".material
@onready var damge = $"damge"
@onready var frame_down = $"frame_down"
@onready var yee = $"yee"
@onready var tree = $"tree"
@onready var star1 = $"star1"
@onready var star2 = $"star2"
@onready var star3 = $"star3"
@onready var frame_up = $"frame_up"
@onready var labal_down = $"labal_down"
@onready var labal_up = $"labal_up"
@onready var title = $"title"
@onready var sword = $"sword"
@onready var icon1 = $"icon1"
@onready var icon2 = $"icon2"
@onready var icon3 = $"icon3"
@onready var pressx = $"pressx"
@onready var pro = $"pro"
@onready var exp = $"exp"
@onready var bg = $"bg"

@export var sword_frame:Array[Texture2D]

var canpress:bool

var damgeV:Vector2
var bgT:float
var bgV:Vector2
var BaseDown:Vector2
var BaseUp:Vector2
var LabalDown:Vector2
var LabalUp:Vector2
var TitleV:Vector2
var TitleR:float
var iconV1:Vector2
var iconV2:Vector2
var icon3V:Vector2
var swordV:Vector2
var proV:Vector2
var expV:Vector2
var yeeV:Vector2
var treeV:Vector2
var yeeV2:Vector2
var treeV2:Vector2

var ricon:float
var riconp:Vector2
var riconb:bool

var ricong:bool
var ricont:float

var ricong2:bool
var ricont2:float

var total:int

func _ready():
	damgeV = damge.position
	yeeV = yee.pivot_offset
	treeV = tree.pivot_offset
	yeeV2 = yee.position
	treeV2 = tree.position
	icon3V = icon3.position
	bgV = bg.position
	expV = exp.position
	riconp = icon1.pivot_offset
	sword.scale = Vector2(2.0,2.0)
	swordV = sword.position
	BaseDown = frame_down.position
	BaseUp = frame_up.position
	TitleV = title.position
	TitleR = title.rotation
	LabalDown = labal_down.position
	LabalUp = labal_up.position
	iconV1 = icon1.position
	iconV2 = icon2.position
	proV = pro.position
	var tween = create_tween()
	tween.tween_method(SetFade, 0.0, 1.0, 2.0).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	var tween2 = create_tween()
	tween2.tween_method(SetFade2, 0.0, 1.0, 3.0).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	#anim.play("skill")
	await get_tree().create_timer(4).timeout
	sword.texture = sword_frame[0]
	var frame_pre = 0.1
	await get_tree().create_timer(frame_pre).timeout
	sword.texture = sword_frame[1]
	await get_tree().create_timer(frame_pre).timeout
	sword.texture = sword_frame[2]
	await get_tree().create_timer(frame_pre).timeout
	sword.texture = sword_frame[3]
	await get_tree().create_timer(frame_pre).timeout
	sword.texture = sword_frame[4]
	canpress = true
	var tween3 = create_tween()
	tween3.tween_method(SetFade4, 0.0, 1.0, 2.0).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(1).timeout
	var tween4 = create_tween()
	tween4.tween_method(SetFade3, 0.0, 1.0, 8.0).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(10).timeout #real 10
	canpress = false
	var tween5 = create_tween()
	tween5.tween_method(SetFade4, 1.0, 0.0, 1.0).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
	sword.texture = sword_frame[3]
	await get_tree().create_timer(frame_pre).timeout
	sword.texture = sword_frame[0]
	await get_tree().create_timer(frame_pre).timeout
	sword.texture = sword_frame[5]
	var tween6 = create_tween()
	tween6.tween_method(SetFade5, 0.0, 1.0, 1.0).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	total += randi_range(1000,10000)
	damge.text = str(total)
	var tween7 = create_tween()
	tween7.tween_method(SetShack, 0.0, 1.0, 6.0).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	riconb = true
	await get_tree().create_timer(3).timeout
	riconb = false
	#icon1.visible = false
	icon2.visible = false
	sword.visible = false
	exp.visible = false
	pro.visible = false
	bgT += 5.0
	
	ricong = true
	await get_tree().create_timer(5).timeout
	ricong = false
	var tween8 = create_tween()
	tween8.tween_method(SetStar, 0.0, 1.0, 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await get_tree().create_timer(0.3).timeout
	var tween9 = create_tween()
	tween9.tween_method(SetStar, 1.0, 0.0, 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(2).timeout
	bgT += 5.0
	yee.visible = true
	tree.visible = true
	await get_tree().create_timer(1).timeout
	yee.flip_h = true
	await get_tree().create_timer(0.5).timeout
	var tween10 = create_tween()
	tween10.tween_method(setRo, 0.0, 1.0, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(0.2).timeout
	var tween11 = create_tween()
	tween11.tween_method(SetBr, 0.0, 1.0, 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	total += randi_range(10000,100000)
	damge.text = str(total)
	var tween12 = create_tween()
	tween12.tween_method(SetShack, 0.0, 1.0, 6.0).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(2).timeout
	bgT += 5.0
	yee.position = yeeV2
	tree.position = treeV2
	ricong2 = true
	await get_tree().create_timer(5).timeout
	ricong2 = false
	var tween13 = create_tween()
	tween13.tween_method(SetStar2, 0.0, 1.0, 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await get_tree().create_timer(0.3).timeout
	var tween14 = create_tween()
	tween14.tween_method(SetStar2, 1.0, 0.0, 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(5).timeout
	_blurbg()
	Global._get_end()

func _blurbg():
	var tweennew = create_tween()
	tweennew.tween_method(SetFadeNew, 0.0, 1.0, 1.0).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)

func SetFadeNew(alpha:float):
	blur.set_shader_parameter("power", alpha*0.4)


func _input(event):
	if event is InputEventKey:
		if event.pressed and canpress:
			pro.value += 1
			var tween = create_tween()
			tween.tween_method(SetSize, 0.0, 1.0, 0.8).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)

func SetSize(alpha:float):
	pressx.scale = lerp(Vector2(1.,1.)*0.5,Vector2(1.,1.)*1.2,alpha)

func SetFade4(alpha:float):
	pressx.scale = Vector2(1.,1.)*alpha

func SetBr(alpha:float):
	yee.position += Vector2(10,100)*alpha
	tree.position += Vector2(-10,-100)*alpha
	yee.rotation = 14.*alpha
	tree.rotation = 10.*alpha



func SetFade3(alpha:float):
	sword.position = swordV + Vector2(randf_range(-1.0,1.0),randf_range(-1.0,1.0))*5.0

func SetFade5(alpha:float):
	exp.scale = Vector2(1.,1.)*alpha*2.

	exp.position = expV + Vector2(randf_range(-1.0,1.0),randf_range(-1.0,1.0))*100.0
	sword.position = swordV + Vector2(randf_range(-1.0,1.0),randf_range(-1.0,1.0))*100.0

func SetShack(alpha:float):
	damge.position = damgeV+Vector2(randf_range(-1.0,1.0),randf_range(-1.0,1.0))*100.0*(1-alpha)
	frame_up.position = BaseUp+Vector2(500,0) + Vector2(randf_range(-1.0,1.0),randf_range(-1.0,1.0))*100.0*(1-alpha)
	frame_down.position = BaseDown+Vector2(-500,0) + Vector2(randf_range(-1.0,1.0),randf_range(-1.0,1.0))*100.0*(1-alpha)
	labal_down.position = LabalDown+Vector2(0,-200) + Vector2(randf_range(-1.0,1.0),randf_range(-1.0,1.0))*100.0*(1-alpha)
	labal_up.position = LabalUp+Vector2(0,200) + Vector2(randf_range(-1.0,1.0),randf_range(-1.0,1.0))*100.0*(1-alpha)

func setRo(alpha:float):
	icon3.position = icon3V + Vector2(4000,0)*alpha

func SetFade2(alpha:float):
	sword.scale = lerp(Vector2(1.0,1.0)*2,Vector2(1.0,1.0),alpha)
	icon1.position = lerp(iconV1-Vector2(1000,-100),iconV1,alpha)
	icon2.scale = lerp(Vector2(1.0,1.0)*2.0,Vector2(1.0,1.0),alpha)
	icon2.position = lerp(iconV2-Vector2(2000,10),iconV2,alpha)

func SetStar(alpha:float):
	star1.scale = lerp(Vector2(0.,0.),Vector2(1.,1.),alpha)
	
func SetStar2(alpha:float):
	star1.scale = lerp(Vector2(0.,0.),Vector2(1.,1.),alpha)
	star2.scale = lerp(Vector2(0.,0.),Vector2(1.,1.),alpha)
	star3.scale = lerp(Vector2(0.,0.),Vector2(1.,1.),alpha)

func SetFade(alpha:float):
	title.scale = lerp(Vector2(1.0,1.0)*1.5,Vector2(1.0,1.0),alpha)
	frame_down.position = lerp(BaseDown,BaseDown+Vector2(-500,0),alpha)
	frame_up.position = lerp(BaseUp,BaseUp+Vector2(500,0),alpha)
	labal_down.position.y = lerp(LabalDown.y,LabalDown.y-200.0,alpha)
	labal_up.position.y = lerp(LabalUp.y,LabalUp.y+200.0,alpha)

func _physics_process(_delta):
	bgT += _delta/10
	bg.position.x = bgV.x + sin(bgT)*600
	bg.position.y = bgV.y + cos(bgT)*300
	star1.rotation = bgT*30
	star2.rotation = bgT*31
	star3.rotation = bgT*32
	icon3.rotation = bgT*30

	if ricong2:
		ricont2 += _delta*20.0
		icon1.rotation = ricont2
		icon1.pivot_offset = riconp - clamp(Vector2(1.0,1.0)*10000/ricont2,Vector2(0.0,0.0),Vector2(1000.0,1000.0))
		icon1.scale = clamp(Vector2(5.0,5.0) - (Vector2(1.0,1.0) * ricont2/20),Vector2(0.,0.),Vector2(10.,10.))
		
		yee.rotation = ricont2 * 2
		yee.pivot_offset = yeeV - clamp(Vector2(1.0,1.0)*10000/ricont2,Vector2(0.0,0.0),Vector2(1000.0,1000.0))
		yee.scale = clamp(Vector2(5.0,5.0) - (Vector2(1.0,1.0) * ricont2/20),Vector2(0.,0.),Vector2(10.,10.))
		
		tree.rotation = ricont2 * 0.8
		tree.pivot_offset = treeV - clamp(Vector2(1.0,1.0)*10000/ricont2,Vector2(0.0,0.0),Vector2(1000.0,1000.0))
		tree.scale = clamp(Vector2(5.0,5.0) - (Vector2(1.0,1.0) * ricont2/20),Vector2(0.,0.),Vector2(10.,10.))
		
	if ricong:
		ricont += _delta*20.0
		icon1.rotation = ricont
		icon1.pivot_offset = riconp - clamp(Vector2(1.0,1.0)*10000/ricont,Vector2(0.0,0.0),Vector2(1000.0,1000.0))
		icon1.scale = clamp(Vector2(5.0,5.0) - (Vector2(1.0,1.0) * ricont/20),Vector2(0.,0.),Vector2(10.,10.))
	if riconb:
		ricon += _delta*20.0
		icon1.rotation = ricon
		icon1.pivot_offset = riconp + Vector2(1.0,1.0)*ricon*10
		icon1.scale = Vector2(1.0,1.0) + (Vector2(1.0,1.0) * ricon/20)
	pro.position = proV + Vector2(randf_range(-1.0,1.0),randf_range(-1.0,1.0))*10.0
	title.position = TitleV + Vector2(randf_range(-1.0,1.0),randf_range(-1.0,1.0))*5.0
	title.rotation = TitleR + randf_range(-1.0,1.0)*0.1
	
	

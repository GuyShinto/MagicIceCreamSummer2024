extends CanvasLayer

#@onready var anim:AnimationPlayer = $"animation"
@onready var frame_down = $"frame_down"
@onready var frame_up = $"frame_up"
@onready var labal_down = $"labal_down"
@onready var labal_up = $"labal_up"
@onready var title = $"title"

var BaseDown:Vector2
var BaseUp:Vector2
var LabalDown:Vector2
var LabalUp:Vector2
var TitleV:Vector2
var TitleR:float

func _ready():
	BaseDown = frame_down.position
	BaseUp = frame_up.position
	TitleV = title.position
	TitleR = title.rotation
	LabalDown = labal_down.position
	LabalUp = labal_up.position
	var tween = create_tween()
	tween.tween_method(SetFade, 0.0, 1.0, 2.0).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	#anim.play("skill")
	pass

func SetFade(alpha:float):
	title.scale = lerp(Vector2(1.0,1.0)*1.5,Vector2(1.0,1.0),alpha)
	frame_down.position = lerp(BaseDown,BaseDown+Vector2(-500,0),alpha)
	frame_up.position = lerp(BaseUp,BaseUp+Vector2(500,0),alpha)
	labal_down.position.y = lerp(LabalDown.y,LabalDown.y-200.0,alpha)
	labal_up.position.y = lerp(LabalUp.y,LabalUp.y+200.0,alpha)

func _physics_process(_delta):
	title.position = TitleV + Vector2(randf_range(-1.0,1.0),randf_range(-1.0,1.0))*5.0
	title.rotation = TitleR + randf_range(-1.0,1.0)*0.1
	
	

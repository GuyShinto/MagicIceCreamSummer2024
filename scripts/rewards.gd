extends Panel

@onready var BG :TextureRect = $"background"
@onready var BG2 :TextureRect = $"background2"
@onready var BGIcon :TextureRect = $"background_icon"
@onready var newIcon :TextureRect = $"new"
@onready var icon :TextureRect = $"icon"
@onready var button :Button = $"button/title"
@onready var blur :ShaderMaterial = $"blur".material
@onready var iconHighlight :Node = $"icon/highlight"

@export var iceCreamList :Array[IceCream]

var hasShow:bool

var time:float

func _ready():
	button.pressed.connect(_pressed)
	self.visible = false
	Global.rewards = self
	#_show(2)
	pass

func _pressed():
	_hide()

func _hide():
	hasShow = false
	var tween = create_tween()
	var tweennew = create_tween()
	tween.tween_method(SetFade, 1.0, 0.0, 1.0).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	tweennew.tween_method(SetFadeNew, 1.0, 0.0, 1.0).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)

func _show(_id):
	for ic in iceCreamList:
		if (ic.id == _id):
			hasShow = true
			get_tree().paused = true
			self.visible = true
			BGIcon.texture = ic.background
			icon.texture = ic.normal
			iconHighlight.normal = ic.normal
			iconHighlight.highlight = ic.highlight
			var tween = create_tween()
			var tweennew = create_tween()
			tween.tween_method(SetFade, 0.0, 1.0, 1.0).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
			tweennew.tween_method(SetFadeNew, 0.0, 1.0, 1.0).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)

func _physics_process(delta):
	if hasShow:
		time += delta/4
		BG.rotation = time
		BG2.rotation = time/2
		BGIcon.scale = Vector2(1.0,1.0) * (1-sin(time*PI)*0.1)
		newIcon.rotation = sin(time*TAU)*0.1
	else:
		time = 0

func SetFadeNew(alpha:float):
	newIcon.modulate.a = alpha
	blur.set_shader_parameter("power", alpha*0.4)
	newIcon.scale = Vector2(1,1) * lerp(1.5,1.0,alpha)

func SetFade(alpha:float):
	BG2.scale = Vector2(1,1) * lerp(0.0,1.1,alpha)
	BG.scale = Vector2(1,1) * lerp(0.0,1.5,alpha)

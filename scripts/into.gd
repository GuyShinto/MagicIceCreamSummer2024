extends Node2D

@onready var _text := $"text"
@onready var camera := $"camera"
@onready var fire := $"fire"
@onready var ele := $"ele"
@onready var face := $"face"
@onready var eye := $"face/eye"

@export var eye5 :Texture

var time:float
var PressA:bool
var fireV:Vector2

func _ready():
	fireV = fire.global_position

func _input(event):
	if event is InputEventKey:
		if event.pressed and not PressA:
			PressA = true
			_starting()
			

func _starting():
	_text.visible = false
	await get_tree().create_timer(2).timeout
	var wait_time = 1.0 #real 10.0
	var tween1 = create_tween()
	tween1.tween_property(camera,"offset:y",0.0,wait_time).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
	await get_tree().create_timer(wait_time).timeout
	await get_tree().create_timer(1).timeout
	fire.visible = true
	await get_tree().create_timer(3).timeout
	var tween2 = create_tween()
	tween2.tween_property(face,"position:y",face.position.y-50,3).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
	await get_tree().create_timer(3).timeout
	ele.modulate = Color8(0,0,0,255)
	AudioManager.exp1.play()
	await get_tree().create_timer(2).timeout
	eye.texture = eye5
	await get_tree().create_timer(4).timeout
	ChangeScene.Change("res://scenes/map.tscn")

func _physics_process(delta):
	if time < TAU:
		time += delta
	else:
		time = 0
	fire.position = fireV + Vector2(randf_range(-1.0,1.0)*10,randf_range(-1.0,1.0)*10)

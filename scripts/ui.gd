extends CanvasLayer

@onready var cursor:TextureRect = $"cursor"

func _physics_process(delta):
	cursor.position = get_viewport().get_mouse_position()

func _input(event):
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("left_click"):
			print("left_click")
		if Input.is_action_just_pressed("right_click"):
			print("right_click")

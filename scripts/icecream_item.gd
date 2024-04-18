extends TextureRect

@export var getItemID:int

var isOver:bool
var time:float
var BaseV:float

func _ready():
	BaseV = self.global_position.y
	self.mouse_entered.connect(_entered)
	self.mouse_exited.connect(_exited)

func _physics_process(delta):
	if time < TAU:
		time += delta
	else:
		time = 0
	self.scale = Vector2(1.,1.) - Vector2(1.,1.)*sin(time*2)*0.1
	self.position.y = BaseV + sin(time*4)*50

func _input(event):
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("left_click"):
			if isOver and getItemID and not Global.player.OnDie:
				if getItemID != 666:
					Global.rewards._show(clamp(getItemID,1,7))
					queue_free()
				else:
					Global.cursor._skill()
					queue_free()

func _entered():
	isOver = true
func _exited():
	isOver = false

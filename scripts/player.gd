extends RigidBody2D

@export var speed = 50
@onready var area:Area2D= $"area"

func _ready():
	Global.player = self
	area.body_entered.connect(_entered)
	area.body_exited.connect(_exited)

func _physics_process(_delta):
	self.angular_velocity = Input.get_axis("left", "right") * speed * _delta

func _entered(_body):
	if _body.is_in_group("ice"):
		Global.temperature.cold.append(_body)
func _exited(_body):
	if _body.is_in_group("ice"):
		Global.temperature.cold.erase(_body)

extends RigidBody2D

@export var speed = 50

func _ready():
	Global.player = self

func _physics_process(_delta):
	self.angular_velocity = Input.get_axis("left", "right") * speed * _delta

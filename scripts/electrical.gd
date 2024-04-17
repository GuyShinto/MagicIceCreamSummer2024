extends Node

@onready var timer :Timer = $"timer"
@onready var main : = $".."

@export var cooly : float
@export var fan : float
@export var maxEnergy:float = 60
@export var watt:float = 1
@export var electricalOff : Texture2D
@export var electricalOn : Texture2D

var hasPlayer:bool

var energy:float

var HasOn:bool

func _ready():
	#energy = maxEnergy
	#timer.wait_time = 1
	main.get_node("area").area_entered.connect(_entered)
	main.get_node("area").area_exited.connect(_exited)
	timer.timeout.connect(_on_timeout)
	timer.start()

func _entered(_area):
	if _area:
		if _area.is_in_group("player"):
			hasPlayer = true
			if energy > 0:
				Global.temperature.cooly.append(self)
func _exited(_area):
	if _area:
		if _area.is_in_group("player"):
			hasPlayer = false
			Global.temperature.cooly.erase(self)

func _add_energy(_value):
	energy = clamp(energy+_value,0,maxEnergy)
	if energy > 0:
		timer.start()
		_on()

func _on_timeout():
	if energy <= 0:
		timer.stop()
		_off()
	else:
		timer.start()
		energy -= watt
		_on()

func _off():
	HasOn = false
	Global.temperature.cooly.erase(self)
	main.get_node("icon").texture = electricalOff

func _on():
	HasOn = true
	main.get_node("icon").texture = electricalOn

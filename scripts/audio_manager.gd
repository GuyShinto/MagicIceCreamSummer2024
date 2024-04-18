extends CanvasLayer

@onready var reward := $"reward"
@onready var malt := $"malt"
@onready var skill_1 := $"skill_1"
@onready var fall := $"fall"
@onready var click := $"click"
@onready var ice1 := $"ice1"
@onready var ice2 := $"ice2"
@onready var ice3 := $"ice3"
@onready var ice4 := $"ice4"
@onready var ice5 := $"ice5"
@onready var exp1 := $"exp1"
@onready var exp2 := $"exp2"
@onready var dark3 := $"dark3"
@onready var dark4 := $"dark4"

@onready var music := $"music"
@onready var sfx := $"sfx"
@onready var button := $"icon/button"
@onready var ishow := $"icon/ishow"

var hasV:bool

func _ready():
	button.pressed.connect(_press)
	music.value_changed.connect(_music_volume)
	sfx.value_changed.connect(_sfx_volume)

func _press():
	hasV = not hasV
	ishow.visible = hasV
	if hasV:
		music.visible = true
		sfx.visible = true
	else:
		music.visible = false
		sfx.visible = false

func _music_volume(_value):
	SetSound(1,_value)
func _sfx_volume(_value):
	SetSound(2,_value)

func SetSound(_track,_volume):
	AudioServer.set_bus_volume_db(_track,linear_to_db(_volume))

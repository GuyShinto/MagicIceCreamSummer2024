extends CanvasLayer

@onready var reward := $"reward"
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

extends CanvasLayer

@export var indexTutorial:Array[Texture2D]

@onready var box:HBoxContainer = $"items/box"
@onready var desc:TextureRect = $"desc"

var item := preload("res://scenes/components/item.tscn")

func _ready():
	Global.ui = self

func _showT(_id):
	desc.visible = true
	desc.texture = indexTutorial[_id-1]

func _hideT():
	desc.visible = false

func _add_item(iceCream):
	Global.items.append(iceCream)
	var thisItem = item.instantiate()
	thisItem.get_node("icon").texture = iceCream.normal
	thisItem.index = iceCream.id
	thisItem.normal = iceCream.normal
	thisItem.highlight = iceCream.highlight
	thisItem.id = Global.items.size()
	box.add_child(thisItem)

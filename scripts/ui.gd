extends CanvasLayer

@onready var box:HBoxContainer = $"items/box"

var item := preload("res://scenes/components/item.tscn")

func _ready():
	Global.ui = self

func _add_item(iceCream):
	Global.items.append(iceCream)
	var thisItem = item.instantiate()
	thisItem.get_node("icon").texture = iceCream.normal
	thisItem.normal = iceCream.normal
	thisItem.highlight = iceCream.highlight
	thisItem.id = Global.items.size()
	box.add_child(thisItem)

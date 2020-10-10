extends Node

# Global vars
var level_num = 0
#onready var inventory = preload('res://Inventory.gd').new()
const Inventory = preload('res://Inventory.gd')
const Item = preload('res://GUI/Item.tscn')
onready var inventory = {}

# Level 0 (intro) specific values
var after_first_attempt = false
var first_time_on_moon = true
var food_collected = false


# Level functions
func update_level_num(level):
	level_num = level

# Inventory functions
#func _input(event):
#	if event.is_action_pressed("click"):
#		add_item("oxy")
#
#		print(inventory)

func add_item(name, texture_path):
	var current_scene = get_tree().get_current_scene()
	var GUI = current_scene.get_node("GUI")
	var icons = GUI.get_node("Inventory/VBoxContainer/Icons")
	
	if inventory.keys().has(name):
		var item = inventory[name]
		item.count += 1
		
		for icon in icons.get_children():
			if icon.item_name == name:
				icon.get_node("Label").text = "x" + str(item.count)
	else:
		inventory[name] = Inventory.new()
		var item = inventory[name]
		item.item_name = name
		item.count = 1
		
		var item_icon_instance = Item.instance()
		item_icon_instance.item_name = name
		item_icon_instance.count = 1
		item_icon_instance.get_node("Label").text = "x1"
		item_icon_instance.get_node("Control/Sprite").texture = load(texture_path)
		icons.add_child(item_icon_instance)

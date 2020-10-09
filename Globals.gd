extends Node

# Global vars
var level_num = 0
#onready var inventory = preload('res://Inventory.gd').new()
const Inventory = preload('res://Inventory.gd')
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

func add_item(name):
	if inventory.keys().has(name):
		var item = inventory[name]
		item.count += 1
	else:
		inventory[name] = Inventory.new()
		var item = inventory[name]
		item.item_name = name
		item.count = 1

extends Node

# Global vars
var level_num = 0
#onready var inventory = preload('res://Inventory.gd').new()
const Inventory = preload('res://Inventory.gd')
const Item = preload('res://GUI/Item.tscn')
onready var inventory = {}
var tether
var old_tether
var tether_area
var old_tether_area

# Level 0 (intro) specific values
var after_first_attempt = false
var first_time_on_moon = true
var food_collected = false

var player

func _ready():
	var current_scene = get_tree().get_current_scene()
	player = current_scene.get_node("World/Player")

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
	
func reset_tether_and_area():
	tether = null
	tether_area = null
	
func attach_player():
	var current_scene = get_tree().get_current_scene()
	var player = current_scene.get_node("World/Player")
	
	if tether != null and tether_area != null:
		var tmp_tether = tether
		var tmp_tether_area = tether_area
		
		# Remove the old tether		
		old_tether.get_node("Joint").node_b = ""
		# Enable the detect player area on the end point
		old_tether.get_node("DetectPlayer/CollisionShape2D").set_deferred("disabled", false)
		# Disable the area col
		old_tether_area.get_node("CollisionPolygon2D").set_deferred("disabled", true)
		
		
		# Attach player to new tether
		# First update the rigid body position
#		tether.mode = RigidBody2D.MODE_STATIC
#		tether.position = player.position
#		tether.apply_central_impulse(Vector2.ZERO)
#		tether.mode = RigidBody2D.MODE_RIGID
		tether.move = true
		
		# Now attach the player
		tether.get_node("Joint").node_a = tether.get_path()
		tether.get_node("Joint").node_b = player.get_path()
		#tether.get_node("PinJoint2D").queue_free()
		# Disable the detect player area on the end point
		tether.get_node("DetectPlayer/CollisionShape2D").set_deferred("disabled", true)
		# Enable the area col
		tether_area.get_node("CollisionPolygon2D").set_deferred("disabled", false)

		# Set the new old tether/area
		old_tether = tmp_tether
		old_tether_area = tmp_tether_area

extends Node

# Global vars
# ------------------------------------------------------------------------------
var edit_mode = false
var level_num = 0
var player
var robot
# ------------------------------------------------------------------------------


# Inventory vars
# ------------------------------------------------------------------------------
#onready var inventory = preload('res://Inventory.gd').new()
const Inventory = preload('res://Inventory.gd')
const Item = preload('res://GUI/Item.tscn')
onready var inventory = {}
# ------------------------------------------------------------------------------


# Tether vars
# ------------------------------------------------------------------------------
var tether
var old_tether
var tether_area
var old_tether_area
var tmp_tether
var tmp_tether_area
var TetherAttach = preload('res://Other/Objects/Tether/DynamicTether/TetherAttach.tscn')
var attaching = false
# ------------------------------------------------------------------------------


# Level 0 (intro) specific values
# ------------------------------------------------------------------------------
var after_first_attempt = false
var first_time_on_moon = true
var food_collected = false
# ------------------------------------------------------------------------------


# Global functions
# ------------------------------------------------------------------------------
func _ready():
	# Assign player var
	var current_scene = get_tree().get_current_scene()
	player = current_scene.get_node("World/Player")
	robot = current_scene.get_node("World/Robot")
	
func toggle_edit_mode():
	edit_mode = !edit_mode
	
func activate_player(value: bool):
	var state = player.get_node("StateMachine")
	if value:
		state.initialize(state.START_STATE)
		state._change_state("idle")
		state.set_active(true)
		
		# Activate camera
		player.get_node("Camera2D").current = true
	else:
		state._change_state("idle")
		state.set_active(false)
		
		# Deactivate camera
		player.get_node("Camera2D").current = false
	
func activate_robot(value: bool):
	var state = robot.get_node("StateMachine")
	if value:
		state.initialize(state.START_STATE)
		state._change_state("idle")
		state.set_active(true)
		
		# Activate camera
		robot.get_node("Camera2D").current = true
	else:
		state._change_state("idle")
		state.set_active(false)
		
		# Deactivate camera
		robot.get_node("Camera2D").current = false
# ------------------------------------------------------------------------------


# Input actions
# ------------------------------------------------------------------------------
func _input(event):
	if event.is_action_pressed("switch_characters"):
		if player.get_node("StateMachine").get_active():
			# Deactivate the player
			activate_player(false)
			
			# Activate robot 
			activate_robot(true)
		else:
			# Activate the player
			activate_player(true)
			
			# Deactivate robot 
			activate_robot(false)
# ------------------------------------------------------------------------------
	
# Level functions	
# --------------------------------------------------------------------
func update_level_num(level):
	level_num = level
# ------------------------------------------------------------------------------


# Inventory functions
# --------------------------------------------------------------------
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
# ------------------------------------------------------------------------------


# Tether functions
# ------------------------------------------------------------------------------
func reset_tether_and_area():
	tether = null
	tether_area = null
	
	
func attach():
	player.can_attach = false
	tmp_tether = tether
	tmp_tether_area = tether_area
	
	get_tree().get_current_scene().move_tether_attach()
	
func finish_attach():
	# Enable the detect player area on the end point
	old_tether.get_node("DetectPlayer/CollisionShape2D").set_deferred("disabled", false)
	# Disable the area col
	old_tether_area.get_node("CollisionPolygon2D").set_deferred("disabled", true)
	
	# Disable the detect player area on the end point
	tether.get_node("DetectPlayer/CollisionShape2D").set_deferred("disabled", true)
	# Enable the area col
	tether_area.get_node("CollisionPolygon2D").set_deferred("disabled", false)

	# Set the new old tether/area
	old_tether = tmp_tether
	old_tether.linear_velocity = Vector2()
	old_tether.set_sleeping(true)
	old_tether_area = tmp_tether_area
	
	# Reset player and attach to him
	player.can_attach = false
	old_tether.get_node("Joint").node_b = player.get_path()
# ------------------------------------------------------------------------------

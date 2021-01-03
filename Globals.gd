extends Node

# Global vars
# ------------------------------------------------------------------------------
var edit_mode = false
var level_num = 0
# ------------------------------------------------------------------------------


# Player vars
# ------------------------------------------------------------------------------
var current_player
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

# Description of tether vars:
# - perspective_tether is set whenever a Player comes into contact with a tether
#		if the perspective_tether is not currently attached to the player, tether is set to its value

var perspective_tether
var tether
var old_tether
var old_bot_tether

var perspective_tether_area
var tether_area
var old_tether_area
var old_bot_tether_area

var attaching = false
var collision_bits = 0
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
	current_player = player

func _process(delta):
	pass

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

func interact(object: String):
	match object:
		"TetherAttach":
			# Display popup to ask if user wants to attach	
			current_player._attach_popup()
			current_player.can_attach = true
			
			# Check if end point is eligible to attach to
			check_tether()

func leave_object(object: String):
	match object:
		"TetherAttach":
			var TetherAttach = get_tree().get_current_scene().get_node("Other/TetherAttach")
			if !TetherAttach.attaching:
				current_player._close_popup()
				current_player.can_attach = false
				reset_tether_and_area()
				
func _switch_characters():
	current_player._close_popup()
	current_player.can_attach = false
	if player.get_node("StateMachine").get_active():
		# Deactivate the player
		activate_player(false)
		
		# Activate robot 
		activate_robot(true)
		current_player = robot
	else:
		# Activate the player
		activate_player(true)
		current_player = player
		
		# Deactivate robot 
		activate_robot(false)
# ------------------------------------------------------------------------------


# Input actions
# ------------------------------------------------------------------------------
func _input(event):
	if event.is_action_pressed("switch_characters"):
		_switch_characters()
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
func check_tether():
	if perspective_tether.get_node("Joint").node_b != current_player.get_path():
		tether = perspective_tether
		tether_area = perspective_tether_area
				
func reset_tether_and_area():
	tether = null
	tether_area = null
	
func attach():
	# Don't allow the player to attach to anything else until complete
	current_player.can_attach = false
	# Close popup
	current_player._close_popup()
	
	# Set the collision bits so area collisions can be set properly
	if current_player.name == "Robot": collision_bits = 1
	else: collision_bits = 0
	
	# Set postition of the end of the tether
	get_tree().get_current_scene().move_tether_attach()
	
	# Remove link from old tether only if Jet is attaching
	# Also disable the area collision
	if current_player.name == "Player":
		old_tether.get_node("Joint").node_b = ""
		old_tether_area.set_collision_mask_bit(0, false)
	
func finish_attach():
	if old_bot_tether != null and current_player.name == "Robot":
		# Enable the detect player area on the end point
		old_bot_tether.get_node("DetectPlayer/CollisionShape2D").set_deferred("disabled", false)
		# Disable the area col
		old_bot_tether_area.set_collision_mask_bit(collision_bits, false)

	# Enable the detect player area on the end point
	old_tether.get_node("DetectPlayer/CollisionShape2D").set_deferred("disabled", false)
	# Disable the area col
	old_tether_area.set_collision_mask_bit(collision_bits, false)
	
	# Disable the detect player area on the end point
	tether.get_node("DetectPlayer/CollisionShape2D").set_deferred("disabled", true)
	# Enable the area col
	tether_area.set_collision_mask_bit(collision_bits, true)
	# Attach player to new tether
	tether.get_node("Joint").node_b = current_player.get_path()

	if current_player.name == "Player":
		# Set the new old tether/area
		old_tether = tether
		old_tether.linear_velocity = Vector2()
		old_tether_area = tether_area
	# Set the old tether info to separate vars for Bot
	else:
		old_bot_tether = tether
		old_bot_tether_area = tether_area

func release(): # Only set to release for Bot - don't think will need to for Jet
	if old_bot_tether != null:
		old_bot_tether.get_node("Joint").node_b = ""
		
		# Enable the detect player area on the end point
		old_bot_tether.get_node("DetectPlayer/CollisionShape2D").set_deferred("disabled", false)
		# Disable the area col for Bot
		old_bot_tether_area.set_collision_mask_bit(1, false)
		
		current_player.can_attach = true
# ------------------------------------------------------------------------------

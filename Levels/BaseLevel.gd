# REMEMBER TO CREATE NEW SCRIPT FILE FOR ANY CUSTOMIZED LEVEL SCRIPTING

class_name BaseLevel
extends Node2D

var TetherEditor = preload("res://Other/Objects/Tether/DynamicTether/EditorBody.tscn")
var currentEditor = null

# Dialog variables
var intro_dialog = null
#["Welcome to the game",
#"Do this, do that",
#"Don't do this, don't do that",
#"This is how you do this",
#"This is how you do that",
#"Good luck"]
export(Color) var dialog_color
export(NodePath) var current_dialog_node

# Level Variables
export(String) var RESTART_SCENE
export(String) var level_name
export(int) var level_num

# Oxy variables
const DEFAULT_OXY_RATE = 1
export(bool) var oxy_status
export(int) var oxy_depletion_rate = DEFAULT_OXY_RATE

# Debug variables
export(bool) var load_edited_tethers = false

func _ready():
	Globals.update_level_num(level_num)
	$GUI.change_level(level_name)
	
	# Every time this node loads in a new scene, dialog needs to process input in order to check if player is on floor
	$GUI/Dialog.set_process(true)
	
	# Turn on/off oxy
	$GUI.set_oxy_status(oxy_status)
	
	# Set oxy rate
	$GUI.set_oxy_rate(oxy_depletion_rate)
	
	# Fade level in
	$GUI/AnimationPlayer.play("level_fade_in")
	
	# Delete the tether editor until needed
	$World/Items/TetherEdit/EditorBody.queue_free()

func _on_dialog_enter():
	pass
	# Virtual function
	# Must be inherited by children if there is anything to be perfomred
	# when entering a dialog area
	
func _on_dialog_exit_before_fade():
	pass
	# Virtual function
	# Must be inherited by children if there is anything to be perfomred
	# when exit a dialog area before fade
	
func _on_dialog_exit_after_fade():
	pass
	# Virtual function
	# Must be inherited by children if there is anything to be perfomred
	# when exit a dialog area after fade
	
func _input(event):
	if Globals.edit_mode:
		var camera = Globals.player.get_node("Camera2D")
		if event.is_action_pressed("move_left"):
			camera.position.x -= 10
		if event.is_action_pressed("move_right"):
			camera.position.x += 10
		if event.is_action_pressed("move_up"):
			camera.position.y -= 10
		if event.is_action_pressed("move_down"):
			camera.position.y += 10
	
func toggle_tether_editor():
	if currentEditor == null:
		currentEditor = TetherEditor.instance()
		$World/Items/TetherEdit.add_child(currentEditor)
	else:
		currentEditor.queue_free()
		currentEditor = null
	
func kill_player():
	pass

func move_tether_attach():
	$Other/TetherAttach.begin_attach()

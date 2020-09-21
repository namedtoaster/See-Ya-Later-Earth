# REMEMBER TO CREATE NEW SCRIPT FILE FOR ANY CUSTOMIZED LEVEL SCRIPTING

class_name BaseLevel
extends Node2D

var intro_dialog = null
#["Welcome to the game",
#"Do this, do that",
#"Don't do this, don't do that",
#"This is how you do this",
#"This is how you do that",
#"Good luck"]
export(Color) var dialog_color
export(NodePath) var current_dialog_node

export(String) var NEXT_SCENE
export(String) var level_name
export(bool) var oxy_status

func _ready():
	$GUI.change_level(level_name)
	
	# Every time this node loads in a new scene, dialog needs to process input in order to check if player is on floor
	$GUI/Dialog.set_process(true)
	
	# Turn off oxy
	$GUI.set_oxy_status(oxy_status)

func _on_LevelEnd_body_entered(body):
	if (body.name == "Player"):
		assert(get_tree().change_scene(NEXT_SCENE) == OK)

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

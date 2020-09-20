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

var conversation
# ID of character

export(String) var NEXT_SCENE

func _ready():
	$GUI.change_level("0 - Space Ship")
	
	# Every time this node loads in a new scene, dialog needs to process input in order to check if player is on floor
	$GUI/Dialog.set_process(true)
	
	# Turn off oxy
	$GUI.set_oxy_status(false)
	
	# Enable the first dialog node
	$Dialogs/DialogArea.set_status(true)

func _on_LevelEnd_body_entered(body):
	if (body.name == "Player"):
		assert(get_tree().change_scene(NEXT_SCENE) == OK)

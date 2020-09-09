extends Node2D

var intro_dialog = ["Um...",
"It looks like the oxygen level is...",
"Decreasing!",
"Gotta find some oxygen...",
"...and fast!"]

export(String) var NEXT_SCENE

func _ready():
	$GUI.change_level(0)
	
	# Every time this node loads in a new scene, dialog needs to process input in order to check if player is on floor
	$GUI/Dialog.set_process(true)

func _on_LevelEnd_body_entered(body):
	if (body.name == "Player"):
		assert(get_tree().change_scene(NEXT_SCENE) == OK)

extends Node2D

var intro_dialog = null
#["You made it to level 2",
#"Have fun or something"]

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$GUI.change_level(2)
	
	# Every time this node loads in a new scene, dialog needs to process input in order to check if player is on floor
	$GUI/Dialog.set_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

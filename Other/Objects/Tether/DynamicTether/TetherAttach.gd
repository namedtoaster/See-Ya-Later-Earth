class_name TetherAttach
extends KinematicBody2D

var attaching = false
export var move_speed = 200

func _ready():
	set_process(true)

func _process(_delta):
	if attaching:
		_go_to_mouse()
		
func begin_attach():
	# Close popup
	Globals.player._close_popup()
	# Don't allow player to attach until hitting another tether
	Globals.player.can_attach = false
	# Set move body to position of new tether
	position = Globals.tether.global_position
	# Remove link from old tether
	Globals.old_tether.get_node("Joint").node_b = ""
	# Allow move body to update position
	attaching = true
	
func _go_to_mouse():
	# Attach new tether to move body
	Globals.tether.get_node("Joint").node_b = get_path()
	
	var direction = Globals.player.position - position
	var normalized_direction = direction.normalized()
	move_and_slide(normalized_direction * move_speed)
	
	if abs(direction.x) <= 5 and abs(direction.y) <= 5:
		attaching = false
		Globals.finish_attach()

class_name TetherAttach
extends KinematicBody2D

var attaching = false
export var move_speed = 200

func _ready():
	set_process(true)

func _process(_delta):
	if attaching:
		_attach()
		
func begin_attach():
	# Set move body to position of new tether
	position = Globals.tether.global_position

	# Allow move body to update position
	attaching = true
	
func _attach():
	# Attach new tether to move body
	Globals.tether.get_node("Joint").node_b = get_path()
	
	var direction = Globals.current_player.position - position
	var normalized_direction = direction.normalized()
	move_and_slide(normalized_direction * move_speed)
	
	if abs(direction.x) <= 5 and abs(direction.y) <= 5:
		attaching = false
		Globals.finish_attach()

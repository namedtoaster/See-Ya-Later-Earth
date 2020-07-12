extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	$GUI/PlayerStats.update_move_values($Player/StateMachine/Move.velocity)
	$GUI/PlayerStats.update_look_values($Player.look_direction)
	$GUI/PlayerStats.update_state($Player/StateMachine.current_state.name)

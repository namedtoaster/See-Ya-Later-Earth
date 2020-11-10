extends RigidBody2D

var move = false

func _integrate_forces(state):
	if move:
		state.transform = Transform2D(0.0, Globals.player.global_position)
		state.linear_velocity = Vector2()
		
		move = false
		#new_pos = Vector2()

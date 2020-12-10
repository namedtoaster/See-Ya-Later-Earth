extends RigidBody2D

var move = false
		
func _integrate_forces(state):
	if move and Globals.tether == self:
		state.transform = Transform2D(0.0, Globals.player.position)
		state.linear_velocity = Vector2()
		#get_parent().position = Globals.player.position
		#get_parent().node_b = Globals.player.get_path()
		
		
		#move = false
		#new_pos = Vector2()

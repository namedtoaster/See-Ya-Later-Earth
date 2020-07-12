extends VBoxContainer

func update_move_values(values):
	$MoveVectorX/Value.text = str(values.x)
	$MoveVectorY/Value.text = str(values.y)
	
func update_look_values(values):
	$LookVectorX/Value.text = str(values.x)
	$LookVectorY/Value.text = str(values.y)
	
func update_state(value):
	$State/Value.text = value
	
func update_FPS(value):
	$FPS/Value.text = value
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

extends KinematicBody2D


func _process(_delta):
	global_position = get_global_mouse_position()
	
func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
		# zoom in
			if event.button_index == BUTTON_WHEEL_UP:
				$Sprite.scale += Vector2(0.1, 0.1)
				$CollisionShape2D.scale += Vector2(0.1, 0.1)
				# call the zoom function
			# zoom out
			if event.button_index == BUTTON_WHEEL_DOWN:
				$Sprite.scale -= Vector2(0.1, 0.1)
				$CollisionShape2D.scale -= Vector2(0.1, 0.1)

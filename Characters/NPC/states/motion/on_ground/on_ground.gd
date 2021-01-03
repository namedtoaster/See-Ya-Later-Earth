extends "../motion.gd"

var velocity = Vector2()

func handle_input(event):
	if event.is_action_pressed("jump"):
		emit_signal("finished", "jump")
	if event.is_action_pressed("interact"):
		if get_owner().name == "Robot" and get_owner().can_attach:
			Globals.attach()
	if event.is_action_released("interact"):
		if get_owner().name == "Robot":
			Globals.release()
	return .handle_input(event)
	
func update(delta):		
	.update(delta)
	
func _on_animation_finished(anim_name):
	._on_animation_finished(anim_name)

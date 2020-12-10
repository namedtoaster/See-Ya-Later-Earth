extends "../motion.gd"

var speed = 0.0
var velocity = Vector2()

func handle_input(event):
	if event.is_action_pressed("jump"):
		emit_signal("finished", "jump")
	if event.is_action_pressed("interact"):
		if get_owner().name == "Player" and get_owner().can_attach:
			Globals.attach()
	return .handle_input(event)

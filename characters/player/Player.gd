extends Character

func set_dead(value):
	$StateMachine.set_active(false)
	$AnimationPlayer.play("die")
	.set_dead(value)

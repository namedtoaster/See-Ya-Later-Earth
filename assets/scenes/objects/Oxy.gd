extends Area2D

export(int) var oxy_increase_amount = 15

func _on_Oxy_body_entered(body):
	if body.name == "Player":
		get_tree().get_current_scene().get_node("GUI").increase_oxy(oxy_increase_amount)
		$PlayerCollisionDetection.disabled = true
		$AnimationPlayer.play("fade_away")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_away":
		queue_free()

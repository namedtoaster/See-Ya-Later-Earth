extends StaticBody2D

export(float) var camera_shake = 0.0

func _process(delta):
	if $AnimationPlayer.is_playing():
		var camera = get_tree().get_current_scene().get_node("World/Player/Camera2D")
		
		camera.set_offset(Vector2( \
			rand_range(-1.0, 1.0) * camera_shake, \
			rand_range(-1.0, 1.0) * camera_shake \
		))


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		$AnimationPlayer.play("attempt_door_open")

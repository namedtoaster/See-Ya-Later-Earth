extends CanvasLayer
	
func change_level(level):
	$TopLabels/HBoxContainer/Level.text = "Level: " + str(level)
	
func _process(delta):
	# Check if dialog playing i.e. its processing is paused. If it is, pause the progress bar too
	var dialog_node = get_node("Dialog")
	var progress = get_node("TopLabels/HBoxContainer/OxygenCounter/TextureProgress")
	if (dialog_node.is_processing_input()):
		progress.set_process(false)
	if (!dialog_node.is_processing_input()):
		progress.set_process(true)
		
func increase_oxy(amount):
	var progress = $TopLabels/HBoxContainer/OxygenCounter/TextureProgress
	progress.increase_value = true
	progress.increase_amount = amount
	
func set_oxy_status(value):
	$TopLabels/HBoxContainer/OxygenCounter/TextureProgress.decrease = value
	
	if value:
		$TopLabels/HBoxContainer/OxygenCounter/TextureProgress.visible = true
		$TopLabels/HBoxContainer/OxygenCounter/Label.visible = true
	else:
		$TopLabels/HBoxContainer/OxygenCounter/TextureProgress.visible = false
		$TopLabels/HBoxContainer/OxygenCounter/Label.visible = false
		
func set_oxy_rate(rate):
	$TopLabels/HBoxContainer/OxygenCounter/TextureProgress.BAR_SPEED = rate
	
func _input(event):
	pass
#	if event.is_action_pressed("move_left"):
#		$BottomMenu/VBoxContainer2/Keys/LeftRight/Left.modulate = Color(1, 1, 1, 1)
#	else:
#		$BottomMenu/VBoxContainer2/Keys/LeftRight/Left.modulate = Color(1, 1, 1, 0)
#
#	if event.is_action_pressed("move_right"):
#		$BottomMenu/VBoxContainer2/Keys/LeftRight/Right.modulate = Color(1, 1, 1, 1)
#	else:
#		$BottomMenu/VBoxContainer2/Keys/LeftRight/Right.modulate = Color(1, 1, 1, 0)
#
#	if event.is_action_pressed("jump"):
#		$BottomMenu/VBoxContainer2/Keys/Spacebar.modulate = Color(1, 1, 1, 1)
#	else:
#		$BottomMenu/VBoxContainer2/Keys/Spacebar.modulate = Color(1, 1, 1, 0)


func _on_TextureProgress_value_changed(value):
	if value <= 0.0:
		$AnimationPlayer.play("death_fade_in")
		
		var player = get_tree().get_current_scene().get_node("World/Player")
		player.set_dead(true)
		
		$Timers/RestartTimer.start()


func _on_RestartTimer_timeout():
	var current_level = get_tree().get_current_scene()
	current_level.go_to_scene(current_level.RESTART_SCENE)

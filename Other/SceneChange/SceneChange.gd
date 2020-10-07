extends Node2D

export(String) var NEXT_SCENE
		
func _on_Timer_timeout():
	var GUI = get_tree().get_current_scene().get_node("GUI")
	GUI.update_change_node(get_path())
	GUI.get_node("AnimationPlayer").play("level_fade_out")

func _on_Area_body_entered(body):
	if (body.name == "Player"):
		$Timer.start()
		
		var player = get_tree().get_current_scene().get_node("World/Player")
		var state_machine = player.get_node("StateMachine")
		
		# Make sure the player is idling and not running or anything else
		state_machine._change_state("idle")
		# Set the player to inactive so they can't move around
		state_machine.set_active(false)

class_name NPC
extends Character

var dialog_text = null

export(float) var MULTIPLIER = 1.0

func _ready():
	speed.x = $StateMachine/Move.MAX_WALK_SPEED
	
	# This signal doesn't actually do anything
	#emit_signal("direction_changed", value)

func _on_DialogArea_body_entered(body):
	if (body.name == "Player"):
		var dialog = get_tree().get_current_scene().get_node("GUI").get_node("Dialog")
		dialog.change_dialog_text(dialog_text)
		
		# Deactivate the area for now
		$DialogArea.visible = false

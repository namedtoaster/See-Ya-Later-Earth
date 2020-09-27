extends Node2D

export(float) var delay_start = 0.001
export(Array) var dialog_text = [["write", "character", "dialog", "here"]]
export(Array) var dialog_color = [Color(0,0,0)]
export(Array) var names = ["Player"]
export(bool) var deactivate_player = true
export(bool) var activate_player = true

func set_status(status):
	$Area2D/CollisionShape2D.disabled = !status

func _on_Area2D_body_entered(body):
	if (body.name == "Player"):
		var dialog = get_tree().get_current_scene().get_node("GUI").get_node("Dialog")
		dialog.change_dialog_text(get_path())

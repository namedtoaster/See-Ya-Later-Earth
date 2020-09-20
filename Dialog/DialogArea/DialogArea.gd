extends Node2D

export(float) var delay_start = 0.001
export(Array) var dialog_text = [["write", "character", "dialog", "here"]]
export(Array) var dialog_color = [Color(0,0,0)]
export(Array) var names = ["Player"]

func _ready():
	$Area2D/CollisionShape2D.disabled = true

func set_status(status):
	$Area2D/CollisionShape2D.disabled = !status

func _on_Area2D_body_entered(body):
	if (body.name == "Player"):
		var dialog = get_tree().get_current_scene().get_node("GUI").get_node("Dialog")
		dialog.change_dialog_text(get_path())
		$Area2D/CollisionShape2D.disabled = true
					
func leave_ship():
	var nav_node = get_tree().get_current_scene().get_node("Other/ExitShip/Navigation2D")
	nav_node.begin()

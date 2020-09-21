extends BaseLevel

func _on_dialog_exit_after_fade():
	var dialog_node = get_node("GUI/Dialog")
	var current_dialog_name = dialog_node.calling_node.name
	
	if current_dialog_name == "ShipInterior":
		var nav_node = get_node("Other/ExitShip/Navigation2D")
		nav_node.begin()
		dialog_node.calling_node.queue_free()

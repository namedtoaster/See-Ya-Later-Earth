extends BaseLevel

func _on_dialog_exit_after_fade():
	var dialog_node = get_node("GUI/Dialog")
	var current_dialog_name = dialog_node.calling_node.name
	
	if current_dialog_name == "KillPlayer":
		var player = get_node("World/Player")
		get_node("GUI").set_oxy_rate(80)
		
func _on_dialog_enter():
	var dialog_node = get_node("GUI/Dialog")
	var current_dialog_name = dialog_node.calling_node.name
	
	if current_dialog_name == "KillPlayer":
		get_node("GUI").set_oxy_rate(0)

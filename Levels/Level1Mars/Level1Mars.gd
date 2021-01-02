extends BaseLevel

func _ready():
	._ready()

func _on_dialog_exit_before_fade():
	var dialog_node = get_node("GUI/Dialog")
	var current_dialog_name = dialog_node.calling_node.name
	
	if current_dialog_name == "Land":
		dialog_node.calling_node.queue_free()

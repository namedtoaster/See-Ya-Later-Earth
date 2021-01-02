extends BaseLevel

var key_found = false
var crowbar_found = false

func _ready():	
	._ready()

func _on_dialog_exit_after_fade():
	var dialog_node = get_node("GUI/Dialog")
	var current_dialog_name = dialog_node.calling_node.name
		
	if current_dialog_name == "CrowbarOpen":
		var nav_node = get_node("Other/EnterPitStop/Navigation2D")
		var exit_location = get_node("Other/EnterPitStop/ExitLocation").position
		nav_node.begin(exit_location)
		dialog_node.calling_node.queue_free()

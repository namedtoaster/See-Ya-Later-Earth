extends BaseLevel

func _ready():	
	if Globals.first_time_on_moon:
		$Dialogs/KillPlayer/Area2D/CollisionShape2D.disabled = false
		Globals.first_time_on_moon = false
	else:
		$Dialogs/KillPlayer/Area2D/CollisionShape2D.disabled = true
		oxy_depletion_rate = DEFAULT_OXY_RATE
		
	._ready()

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

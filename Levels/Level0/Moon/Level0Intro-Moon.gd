extends BaseLevel

var key_found = false
var crowbar_found = false

func _ready():	
	._ready()
	
	if Globals.first_time_on_moon:
		get_node("GUI").set_oxy_rate(0)
		$Dialogs/OxyHint/Area2D/CollisionShape2D.set_deferred("disabled", true)
		$Dialogs/KillPlayer/Area2D/CollisionShape2D.set_deferred("disabled", false)
		$World/Player/BodyPivot/Helmet.visible = false
		Globals.first_time_on_moon = false
	else:
		$Dialogs/KillPlayer/Area2D/CollisionShape2D.set_deferred("disabled", true)
		$Dialogs/OxyHint/Area2D/CollisionShape2D.set_deferred("disabled", false)
		oxy_depletion_rate = DEFAULT_OXY_RATE
		get_node("GUI").set_oxy_rate(oxy_depletion_rate)

func _on_dialog_exit_after_fade():
	var dialog_node = get_node("GUI/Dialog")
	var current_dialog_name = dialog_node.calling_node.name
	
	if current_dialog_name == "KillPlayer":
		var player = get_node("World/Player")
		get_node("GUI").set_oxy_rate(80)
		
	if current_dialog_name == "OxyHint":
		dialog_node.calling_node.queue_free()
		
	if current_dialog_name == "CrowbarOpen":
		var nav_node = get_node("Other/EnterPitStop/Navigation2D")
		var exit_location = get_node("Other/EnterPitStop/ExitLocation").position
		nav_node.begin(exit_location)
		dialog_node.calling_node.queue_free()

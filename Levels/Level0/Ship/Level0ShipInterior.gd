extends BaseLevel

export(bool) var spawning = false

func _ready():
	._ready()
	$LevelEnd/Area.get_node("CollisionShape2D").disabled = true
	
	$Dialogs/FirstAttempt/Area2D/CollisionShape2D.disabled = !Globals.after_first_attempt
	
	if Globals.after_first_attempt:
		Globals.after_first_attempt = false
		$Dialogs/FirstAttempt/Area2D/CollisionShape2D.disabled = false
		$World/Player/BodyPivot/Helmet.visible = true

func _on_dialog_exit_after_fade():
	var dialog_node = get_node("GUI/Dialog")
	var current_dialog_name = dialog_node.calling_node.name
	
	if current_dialog_name == "ShipInterior":
		var nav_node = get_node("Other/ExitShip/Navigation2D")
		nav_node.begin()
		dialog_node.calling_node.queue_free()
		$LevelEnd/Area.get_node("CollisionShape2D").disabled = false
		Globals.after_first_attempt = true
		
	if current_dialog_name == "FirstAttempt":
		var nav_node = get_node("Other/ExitShip/Navigation2D")
		nav_node.begin()
		dialog_node.calling_node.queue_free()
		spawning = true
		$LevelEnd/Area.get_node("CollisionShape2D").disabled = false

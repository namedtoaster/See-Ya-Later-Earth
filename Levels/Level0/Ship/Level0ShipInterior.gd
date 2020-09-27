extends BaseLevel

export(bool) var spawning = false

func _ready():
	._ready()
	get_node("SceneChanges/LevelEnd/Area/CollisionShape2D").set_deferred("disabled", true)
	
	$Dialogs/FirstAttempt/Area2D/CollisionShape2D.disabled = !Globals.after_first_attempt
	
	if Globals.after_first_attempt:
		Globals.after_first_attempt = false
		$Dialogs/FirstAttempt/Area2D/CollisionShape2D.set_deferred("disabled", false)
	else:
		$World/Player/BodyPivot/Helmet.visible = false

func _on_dialog_exit_after_fade():
	var dialog_node = get_node("GUI/Dialog")
	var current_dialog_name = dialog_node.calling_node.name
	
	if current_dialog_name == "ShipInterior":
		var nav_node = get_node("Other/ExitShip/Navigation2D")
		var exit_location = get_node("Other/ExitShip/ExitLocation").position
		nav_node.begin(exit_location)
		dialog_node.calling_node.queue_free()
		get_node("SceneChanges/LevelEnd/Area/CollisionShape2D").set_deferred("disabled", false)
		Globals.after_first_attempt = true
		
	if current_dialog_name == "FirstAttempt":
		var nav_node = get_node("Other/ExitShip/Navigation2D")
		var exit_location = get_node("Other/ExitShip/ExitLocation").position
		nav_node.begin(exit_location)
		dialog_node.calling_node.queue_free()
		spawning = true
		get_node("SceneChanges/LevelEnd/Area/CollisionShape2D").set_deferred("disabled", false)

extends BaseLevel

export(bool) var spawning = false

func _ready():
	._ready()
	level_specific_setup()

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
		
func level_specific_setup():
	var level_num = Globals.level_num
	
	if (level_num == 0):
		$SceneChanges/LevelEnd/Area/CollisionShape2D.set_deferred("disabled", !Globals.after_first_attempt)
		$Dialogs/Level0/FirstAttempt/Area2D/CollisionShape2D.disabled = !Globals.after_first_attempt
		$World/Player/BodyPivot/Helmet.visible = Globals.after_first_attempt
		
		if Globals.after_first_attempt:
			Globals.after_first_attempt = false
	elif (level_num == 1):
		# Delete the dialog nodes from previous level
		for node in $Dialogs/Level0.get_children():
			node.queue_free()
		
		$World/Player.position = $Other/Positions/JetChair.position
		$World/NPCs/Robot.position = $Other/Positions/BotChair.position

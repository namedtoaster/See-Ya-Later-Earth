extends BaseLevel

export(bool) var spawning = false

func _ready():
	._ready()
	check_level_change()
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
		leave_ship()
		dialog_node.calling_node.queue_free()
		spawning = true
		get_node("SceneChanges/LevelEnd/Area/CollisionShape2D").set_deferred("disabled", false)
	elif current_dialog_name == "TravelToMars":
		leave_ship()
		dialog_node.calling_node.queue_free()

func leave_ship():
	var nav_node = get_node("Other/ExitShip/Navigation2D")
	var exit_location = get_node("Other/ExitShip/ExitLocation").position
	nav_node.begin(exit_location)
	
func check_level_change():
	if Globals.food_collected or level_num == 1:
		level_num = 1
		get_node("SceneChanges/LevelEnd").NEXT_SCENE = "res://Levels/Level1.Mars/Level1.Mars.tscn"
	
func level_specific_setup():
	Globals.update_level_num(level_num)
	$GUI.change_level(level_name)
	
	for node in get_node("Dialogs").get_children():
		if !(str(level_num) in node.name):
			node.queue_free()
	
	if (level_num == 0):
		$SceneChanges/LevelEnd/Area/CollisionShape2D.set_deferred("disabled", !Globals.after_first_attempt)
		$Dialogs/Level0/FirstAttempt/Area2D/CollisionShape2D.disabled = !Globals.after_first_attempt
		$World/Player/BodyPivot/Helmet.visible = Globals.after_first_attempt
		
		if Globals.after_first_attempt:
			Globals.after_first_attempt = false
	elif (level_num == 1):
		$World/Player.position = $Other/Positions/JetChair.position
		$World/NPCs/Robot.position = $Other/Positions/BotChair.position

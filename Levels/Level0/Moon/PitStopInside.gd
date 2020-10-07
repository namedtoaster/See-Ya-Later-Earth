extends BaseLevel

func _ready():
	._ready()
	
	get_node("SceneChanges/LevelEnd/Area/CollisionShape2D").set_deferred("disabled", true)
	get_node("Dialogs/GotFood/Area2D/CollisionShape2D").set_deferred("disabled", true)
	get_node("GUI").set_oxy_rate(0)
	
func _on_dialog_exit_before_fade():
	var dialog_node = get_node("GUI/Dialog")
	var current_dialog_name = dialog_node.calling_node.name
	
	if current_dialog_name == "NoticeOxy":
		dialog_node.calling_node.queue_free()
	elif current_dialog_name == "GotFood":
		get_node("SceneChanges/LevelEnd/Area/CollisionShape2D").set_deferred("disabled", false)
		dialog_node.calling_node.queue_free()

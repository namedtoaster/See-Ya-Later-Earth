extends Area2D

export(String) var item_name = "item"

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_away":
		queue_free()
	
func item_collected():
	get_node("PlayerCollisionDetection").set_deferred("disabled", true)
	$AnimationPlayer.play("fade_away")
	var current_scene = get_tree().get_current_scene()
	
	if item_name == "food":
		current_scene.get_node("Dialogs/GotFood/Area2D/CollisionShape2D").set_deferred("disabled", false)
	elif item_name == "crowbar":
		var pit_stop = current_scene.get_node("World/PitStop")
		var open_door_dialog_node = pit_stop.get_node("OpenDoor")
		open_door_dialog_node.queue_free()
	elif item_name == "oxy":
		current_scene.get_node("GUI").increase_oxy(20)
		Globals.add_item("oxy", "res://Other/Objects/assets/oxy.png")
	elif item_name == "hypercore":
		Globals.add_item("hypercore", "res://assets/images/objects/hypercore.png")


func _on_Item_body_entered(body):
	if body.name == "Player":
		item_collected()

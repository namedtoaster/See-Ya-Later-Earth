extends Area2D

func _on_Area2D_body_entered(body):
	if body.name == "Player" and !body.attached:
		print("test")
		var link = get_parent().get_node("RopeLink3")
		link.node_a = get_parent().get_path()
		link.node_b = body.get_path()
		body.attached = true
		get_owner().get_parent().get_owner().get_node("Area2D/CollisionPolygon2D").set_deferred("disabled", false)
		Globals.set_tether_and_area(get_owner().get_node("RopeLink3").get_path(),get_owner().get_parent().get_owner().get_node("Area2D/CollisionPolygon2D").get_path())

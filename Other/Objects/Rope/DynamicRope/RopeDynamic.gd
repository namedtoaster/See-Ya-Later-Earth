extends Node2D

var RopePoint = preload("res://Other/Objects/Rope/DynamicRope/RopePointDynamic.tscn")
export(int)var num_links = 1
export(int)var point_separation = 20
onready var current_point = $Anchor/RopeLink/RopePoint

func _ready():
	for i in range(1, num_links):
		var new_child
		
		# Link the new child with pin joint
		#current_point.get_node("PinJoint2D").node_a = current_point.get_path()
		
		# If on the last point, link up the anchor
#		if i == num_links - 1:
#			new_child = get_node("RopeEnd")
#			# Be sure to reset position (offset in scene just to make it visible when editing)
#			new_child.position.x = 0
#			new_child.position.y = 0
#		else:
		new_child = RopePoint.instance()

		new_child.position.y += point_separation	
		current_point.add_child(new_child)
		current_point.get_node("PinJoint2D").node_b = new_child.get_path()
		
		# Update the current child var
		current_point = new_child


func _on_RopeEnd_body_entered(body):
	if body.name == "TetherCollision":
		if !body.get_parent().attached:
			var link = get_parent().get_node("RopeLink3")
			link.node_a = get_parent().get_path()
			link.node_b = body.get_path()
			body.get_parent().attached = true
			#$CollisionShape2D.set_deferred("disabled", true)
			get_owner().get_parent().get_owner().get_node("Area2D/CollisionPolygon2D").set_deferred("disabled", false)
			Globals.set_tether_and_area(get_owner().get_node("RopeLink3").get_path(),get_owner().get_parent().get_owner().get_node("Area2D/CollisionPolygon2D").get_path())

extends Node2D

var RopePoint = preload("res://Other/Objects/Rope/DynamicRope/RopePointDynamic.tscn")
var EndPoint
var RopeEndTex = preload("res://Other/Objects/Rope/DynamicRope/rope_end.png")
export(int)var num_links = 1
onready var current_point = $Anchor/RopeLink/RopePoint

func _ready():
	for i in range(1, num_links):
		var new_child
		new_child = RopePoint.instance()
		
		var pin_joint = current_point.get_node("PinJoint2D")
		pin_joint.node_a = current_point.get_path()
		pin_joint.add_child(new_child)
		pin_joint.node_b = new_child.get_path()
		#get_node(pin_joint.node_b).position = Vector2(0.0, point_separation)
		
		# Update the current child var
		current_point = new_child
		if i == num_links - 1:
			current_point.contact_monitor = true
			current_point.contacts_reported = 3
			current_point.get_node("Sprite").set_texture(RopeEndTex)
			current_point.connect("body_entered", self, "_hit")
			EndPoint = current_point
			
	$Area2D.scale = Vector2(1.0 * num_links / 35, 1.0 * num_links / 35)

func _hit(body):
	if body.name == "TetherCollision":
		if !body.get_parent().attached:
			var link = EndPoint.get_node("PinJoint2D")
			link.node_b = body.get_path()
			body.get_parent().attached = true
			#$CollisionShape2D.set_deferred("disabled", true)
			#get_owner().get_parent().get_owner().get_node("Area2D/CollisionPolygon2D").set_deferred("disabled", false)
			$Area2D/CollisionPolygon2D.set_deferred("disabled", false)
			#Globals.set_tether_and_area(get_owner().get_node("RopeLink3").get_path(),get_owner().get_parent().get_owner().get_node("Area2D/CollisionPolygon2D").get_path())

func _on_RopeEnd_body_entered(body):
	if body.name == "TetherCollision":
		if !body.get_parent().attached:
			var link = EndPoint
			link.node_b = body.get_path()
			body.get_parent().attached = true
			#$CollisionShape2D.set_deferred("disabled", true)
			#get_owner().get_parent().get_owner().get_node("Area2D/CollisionPolygon2D").set_deferred("disabled", false)
			$Area2D/CollisionPolygon2D.set_deferred("disabled", false)
			#Globals.set_tether_and_area(get_owner().get_node("RopeLink3").get_path(),get_owner().get_parent().get_owner().get_node("Area2D/CollisionPolygon2D").get_path())


func _on_RopePoint_body_entered(body):
	print("test") # Replace with function body.

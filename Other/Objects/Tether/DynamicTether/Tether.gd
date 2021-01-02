extends Node2D

var TetherPoint = preload("res://Other/Objects/Tether/DynamicTether/TetherPoint.tscn")
var TetherEndTex = preload("res://Other/Objects/Tether/DynamicTether/tether_end.png")

var EndPoint
var player
var load_position_data = []
var load_rotation_data = []
export(int)var num_links = 1
export(String)var tether_name = "Tether"
onready var current_point = $Anchor/RopeLink/TetherPoint
onready var SAVE_KEY: String = "tether_" + name

func _ready():
	# See if any tethers can be loaded for the current level
	var current_level = get_tree().get_current_scene()
	var level_name = current_level.name
	var level_num = str(current_level.level_num)
	var load_tethers = current_level.load_edited_tethers
	if load_tethers:
		GameSaver.load(1, level_num)
	
	# Get rid of the DetectPlayer node on the first TetherPoint
	current_point.get_node("DetectPlayer").queue_free()
	
	# Get the player
	player = Globals.player
	
	for i in range(1, num_links):
		# Create a new rope point and link it as appropriate
		var new_child = TetherPoint.instance()
		if load_position_data != [] and load_rotation_data != []:
			new_child.position = load_position_data[i]
			new_child.rotation = load_rotation_data[i]
		else:
			new_child.position.y = (i- 1) * 5
		
		var pin_joint = current_point.get_node("Joint")
		pin_joint.node_a = current_point.get_path()
		$Anchor/RopeLink.add_child(new_child)
		pin_joint.node_b = new_child.get_path()
		#get_node(pin_joint.node_b).position = Vector2(0.0, point_separation)
		
		# Update the current child var
		current_point = new_child
		
		# If on last iteration, set TetherPoint to be the end
		if i == num_links - 1:
			current_point.get_node("Sprite").set_texture(TetherEndTex)
			current_point.get_node("DetectPlayer").connect("body_entered", self, "_hit")
			current_point.get_node("DetectPlayer").connect("body_exited", self, "_leaving_hit")
			EndPoint = current_point
		else:
			# Remove the DetectPlayer node on each rope point except the last
			current_point.get_node("DetectPlayer").queue_free()
		
	# If this is the ship tether, attach the player to the end
	if tether_name == "Ship Tether":
		var end = EndPoint.get_node("Joint")
		end.node_a = EndPoint.get_path()
		end.node_b = player.get_path()
		
		# Disable the player detect area so the popup won't display
		EndPoint.get_node("DetectPlayer/CollisionShape2D").set_deferred("disabled", true)
		
		# Set the old tether vars so they can be disconnected when the time comes
		Globals.old_tether = EndPoint
		Globals.old_tether_area = $Area2D
		
		# Also, enable the area collision
		$Area2D/CollisionPolygon2D.set_deferred("disabled", false)
		
	# Set the scale of the area collision based on how many links there are
	$Area2D.scale = Vector2(1.0 * num_links / 35, 1.0 * num_links / 35)
		
func _leaving_hit(body):
	var TetherAttach = get_tree().get_current_scene().get_node("Other/TetherAttach")
	if body.name == "Player" and !TetherAttach.attaching:
		body._close_popup()
		body.can_attach = false
		Globals.reset_tether_and_area()

func _hit(body):
	if body.name == "Player":
		new_tether(true)
		
func save(save_game: Resource):
	# Get the position of all the tether links
	var position_data = []
	var rotation_data = []
	
	for child_link in $Anchor/RopeLink.get_children():
		position_data.append(child_link.position)
		rotation_data.append(child_link.rotation)
		
	save_game.data[SAVE_KEY] = {
		'position_data': position_data,
		'rotation_data': rotation_data
	}
	
func load(save_game: Resource):
	if SAVE_KEY != null:
		var data: Dictionary = save_game.data[SAVE_KEY]
		load_position_data = data['position_data']
		load_rotation_data = data['rotation_data']
				
func new_tether(popup):
	# Display popup to ask if user wants to attach			
	if popup:
		Globals.player._attach_popup()
	Globals.player.can_attach = true
		
	if EndPoint.get_node("Joint").node_b != player.get_path():
		Globals.tether = EndPoint
		Globals.tether_area = $Area2D

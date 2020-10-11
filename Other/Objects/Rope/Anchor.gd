extends StaticBody2D

const RopePoint = preload("res://Other/Objects/Rope/RopePoint.tscn")
const RopeLink = preload("res://Other/Objects/Rope/RopeLink.tscn")

export(int)var loops = 1

func _ready():
	for i in range(loops):
		var child = addLoop()
		addLink(child)
		
func addLoop():
	var ropepoint = RopePoint.instance()
	ropepoint.position = position
	ropepoint.position.y += 100
	add_child(ropepoint)
	return ropepoint
	
func addLink(child):
	var ropelink = RopeLink.instance()
	ropelink.node_a = get_path()
	ropelink.node_b = child.get_path()
	add_child(ropelink)

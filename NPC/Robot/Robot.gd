class_name Robot
extends NPC

signal direction_changed(new_direction)

func _ready():
	$CollisionShape2D.disabled = true

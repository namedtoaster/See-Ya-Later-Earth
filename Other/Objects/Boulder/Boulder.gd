extends KinematicBody2D

onready var path_follow = get_parent()
var enabled = true

var speed = 200

func _physics_process(delta):
	if enabled:
		var prepos = path_follow.get_global_position()
		path_follow.set_offset(path_follow.get_offset() + speed * delta)
		#var pos = path_follow.get_global_position()


func _on_End_body_entered(body):
	if body.name == "Body":
		get_owner().get_node("AnimationPlayer").play("explode")
		get_owner().get_node("Path2D/PathFollow2D/Body/Sprite").visible = false


func _on_AnimationPlayer_animation_finished(anim_name):
	get_owner().get_node("Explosion").visible = false

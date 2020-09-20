extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Oxy_body_entered(body):
	if body.name == "Player":
		get_tree().get_current_scene().get_node("GUI").increase_oxy(5)
		$PlayerCollisionDetection.disabled = true
		$AnimationPlayer.play("fade_away")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_away":
		queue_free()

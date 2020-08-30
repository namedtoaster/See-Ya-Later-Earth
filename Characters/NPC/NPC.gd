class_name Robot
extends Character

var dialog_text = ["Hey 'der...",
"*bleep*....*bloop*...",
"We don't get a lot of...*bloop*...people around here lately.",
"*bleep* *bloop*...If you want some supplies, there's a shack just Southwest of here.",
"I'm just going to stay out here and enjoy the sun...*bleep*",
"*bleep* *bloop*..."]

signal direction_changed(new_direction)
export(float) var MULTIPLIER = 1.0

var look_direction = Vector2(1, 0) setget set_look_direction

func _ready():
	speed.x = $StateMachine/Move.MAX_WALK_SPEED

func take_damage(attacker, amount, effect=null):
	if self.is_a_parent_of(attacker):
		return
	$States/Stagger.knockback_direction = (attacker.global_position - global_position).normalized()
	$Health.take_damage(amount, effect)

func set_dead(value):
	set_process_input(not value)
	set_physics_process(not value)
	$CollisionPolygon2D.disabled = value

func set_look_direction(value):
	look_direction = value
	
	# This signal doesn't actually do anything
	#emit_signal("direction_changed", value)


func _on_DialogArea_body_entered(body):
	if (body.name == "Player"):
		var dialog = get_tree().get_current_scene().get_node("GUI").get_node("Dialog")
		dialog.change_dialog_text(dialog_text)
		
		# Deactivate the area for now
		$DialogArea.visible = false

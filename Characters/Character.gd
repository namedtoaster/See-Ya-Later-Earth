class_name Character
extends KinematicBody2D

var attached = false
var can_attach = false

# Both the Player and Enemy inherit this scene as they have shared behaviours
# such as speed and are affected by gravity.

export var speed = Vector2(0.0, 450.0)
export(Color) var dialog_color
onready var gravity = ProjectSettings.get("physics/2d/default_gravity")
var look_direction = Vector2(1, 0) setget set_look_direction
var _velocity = Vector2.ZERO
const FLOOR_NORMAL = Vector2.UP

# _physics_process is called after the inherited _physics_process function.
# This allows the Player and Enemy scenes to be affected by gravity.
func _physics_process(delta):
	# Apply gravity - each state will handle the velocity on its own as necessary
	_velocity.y += gravity * delta

func set_look_direction(value):
	look_direction = value
	
func take_damage(attacker, amount, effect=null):
	if self.is_a_parent_of(attacker):
		return
	$States/Stagger.knockback_direction = (attacker.global_position - global_position).normalized()
	$Health.take_damage(amount, effect)

func get_class(): return "Character"

func set_dead(value):
	set_process_input(not value)
	set_physics_process(not value)

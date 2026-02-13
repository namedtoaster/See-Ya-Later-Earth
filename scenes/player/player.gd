class_name Player
extends Node2D

signal direction_changed(new_direction: Vector2)
signal oxygen_changed(current: float, maximum: float)
signal oxygen_depleted()

var look_direction: Vector2 = Vector2(1, 0):
	set(value):
		look_direction = value
		direction_changed.emit(value)

@export var oxygen_data: OxygenData

var current_oxygen: float = 100.0
var tether_system: TetherSystem = null
var is_dead: bool = false

## Current movement velocity (used by tether system to cancel outward movement)
var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	if oxygen_data:
		current_oxygen = oxygen_data.max_oxygen

func _physics_process(delta: float) -> void:
	if is_dead:
		return
	_update_oxygen(delta)

func _update_oxygen(delta: float) -> void:
	if not oxygen_data:
		return

	# Only deplete while moving — standing still costs nothing
	if velocity.length() > 1.0:
		current_oxygen -= oxygen_data.depletion_rate_moving * delta
		current_oxygen = maxf(current_oxygen, 0.0)
		oxygen_changed.emit(current_oxygen, oxygen_data.max_oxygen)

	if current_oxygen <= 0.0 and not is_dead:
		is_dead = true
		oxygen_depleted.emit()

## Called when connecting to a post that has oxygen.
func receive_oxygen(amount: float) -> void:
	if not oxygen_data:
		return
	current_oxygen = minf(current_oxygen + amount, oxygen_data.max_oxygen)
	oxygen_changed.emit(current_oxygen, oxygen_data.max_oxygen)

class_name TetherPost
extends Node2D
## A post the player can tether to. Has a max range and optional oxygen supply.

## Maximum tether rope length in pixels from this post
@export var tether_range: float = 200.0

## How close the player must be to connect (press E)
@export var interact_radius: float = 40.0

## Whether this post provides oxygen on first connection
@export var has_oxygen: bool = true

## How much oxygen this post gives (overrides OxygenData.burst_amount if > 0)
@export var oxygen_amount: float = 0.0

## Whether the player has already collected oxygen from this post
var oxygen_collected: bool = false

@onready var range_indicator: Node2D = $RangeIndicator

var is_active: bool = false

func set_active(active: bool) -> void:
	is_active = active
	range_indicator.queue_redraw()

## Tries to give oxygen to the player. Returns the amount given (0 if already collected).
func collect_oxygen(default_amount: float) -> float:
	if not has_oxygen or oxygen_collected:
		return 0.0
	oxygen_collected = true
	return oxygen_amount if oxygen_amount > 0.0 else default_amount

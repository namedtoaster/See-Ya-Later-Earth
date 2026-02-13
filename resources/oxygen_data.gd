class_name OxygenData
extends Resource
## Configuration for the oxygen system. Create .tres instances with different values per level.

## Maximum oxygen the player can hold
@export var max_oxygen: float = 100.0

## Oxygen depletion rate per second while moving (no drain while idle)
@export var depletion_rate_moving: float = 5.0

## One-time oxygen boost when connecting to a post
@export var burst_amount: float = 50.0

extends TextureProgress

const BAR_SPEED = 2
onready var current_bar_value = 100
var increase_value = false
var increase_amount = 0

func _process(delta):
	current_bar_value -= BAR_SPEED * delta
	if (increase_value):
		current_bar_value = min(100, current_bar_value + increase_amount)
		increase_value = false
	
	# Don't go below zero
	current_bar_value = max(current_bar_value, 0.0)
	
	value = current_bar_value

extends TextureProgress

const BAR_SPEED = 2
var current_bar_value = 100

func _process(delta):
	current_bar_value -= BAR_SPEED * delta
	
	# Don't go below zero
	current_bar_value = max(current_bar_value, 0.0)
	
	value = current_bar_value

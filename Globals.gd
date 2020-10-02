extends Node

var level_num = 0

# Level 0 (intro) specific values
var after_first_attempt = false
var first_time_on_moon = true

func update_level_num(level):
	level_num = level

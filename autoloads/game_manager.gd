extends Node
## Global game state manager. Handles level transitions and restarts.

signal level_completed(level_name: String)

var current_level_index: int = 0
var levels: Array[String] = [
	"res://scenes/level/test_level.tscn",
]

func complete_level() -> void:
	level_completed.emit(levels[current_level_index])
	current_level_index += 1
	if current_level_index < levels.size():
		get_tree().change_scene_to_file(levels[current_level_index])
	else:
		print("All levels complete!")
		current_level_index = 0
		get_tree().change_scene_to_file(levels[0])

func restart_level() -> void:
	get_tree().reload_current_scene()

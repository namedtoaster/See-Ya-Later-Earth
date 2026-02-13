class_name OxygenBar
extends HBoxContainer
## Displays the oxygen level as a progress bar.

@onready var progress: ProgressBar = $ProgressBar
@onready var value_label: Label = $Label

func update_value(current: float, maximum: float) -> void:
	progress.max_value = maximum
	progress.value = current
	value_label.text = "O2: %d%%" % int((current / maximum) * 100.0)

class_name HUD
extends CanvasLayer
## Main heads-up display. Shows oxygen bar and interaction prompts.

@onready var oxygen_bar: OxygenBar = $OxygenBar
@onready var interact_prompt: Label = $InteractPrompt
@onready var state_label: Label = $DebugInfo/StateLabel
@onready var fps_label: Label = $DebugInfo/FPSLabel

func connect_to_player(player: Player) -> void:
	player.oxygen_changed.connect(_on_oxygen_changed)

func _on_oxygen_changed(current: float, maximum: float) -> void:
	oxygen_bar.update_value(current, maximum)

func show_interact_prompt(show: bool) -> void:
	interact_prompt.visible = show

func update_debug(state_name: String) -> void:
	state_label.text = "State: " + state_name
	fps_label.text = "FPS: %d" % Engine.get_frames_per_second()

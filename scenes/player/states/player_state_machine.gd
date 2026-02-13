class_name PlayerStateMachine
extends StateMachine

func _ready() -> void:
	states_map = {
		"idle": $Idle,
		"move": $Move,
	}
	super._ready()

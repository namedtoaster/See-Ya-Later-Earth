class_name State
extends Node
## Base interface for all states. Every state must implement these methods.

signal finished(next_state_name: String)

func enter() -> void:
	pass

func exit() -> void:
	pass

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

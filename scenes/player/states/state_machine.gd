class_name StateMachine
extends Node
## Generic stack-based state machine. Delegates _input and _physics_process
## to the current active state. States emit "finished" to trigger transitions.

signal state_changed(current_state: State)

@export var start_state: NodePath

var states_map: Dictionary = {}
var states_stack: Array = []
var current_state: State = null
var _active: bool = false:
	set(value):
		_active = value
		set_physics_process(value)
		set_process_input(value)
		if not _active:
			states_stack.clear()
			current_state = null

func _ready() -> void:
	for child in get_children():
		if child is State:
			child.finished.connect(_change_state)
	initialize(start_state)

func initialize(initial_state: NodePath) -> void:
	_active = true
	var state_node := get_node(initial_state) as State
	states_stack.push_front(state_node)
	current_state = states_stack[0]
	current_state.enter()

func _input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _change_state(state_name: String) -> void:
	if not _active:
		return
	current_state.exit()

	if state_name == "previous":
		states_stack.pop_front()
	else:
		states_stack[0] = states_map[state_name]

	current_state = states_stack[0]
	state_changed.emit(current_state)

	if state_name != "previous":
		current_state.enter()

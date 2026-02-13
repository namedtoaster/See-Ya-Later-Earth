class_name MoveState
extends State

@export var max_walk_speed: float = 100.0
@export var max_run_speed: float = 200.0

func enter() -> void:
	var anim := owner.get_node("AnimationPlayer") as AnimationPlayer
	if anim and anim.has_animation("walk"):
		anim.play("walk")

func update(delta: float) -> void:
	var input_dir := Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)
	if input_dir == Vector2.ZERO:
		finished.emit("idle")
		return

	if input_dir != Vector2.ZERO and owner.look_direction != input_dir:
		owner.look_direction = input_dir

	var speed := max_run_speed if Input.is_action_pressed("run") else max_walk_speed
	owner.velocity = input_dir.normalized() * speed
	owner.position += owner.velocity * delta

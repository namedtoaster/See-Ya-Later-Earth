class_name IdleState
extends State

func enter() -> void:
	owner.velocity = Vector2.ZERO
	var anim := owner.get_node("AnimationPlayer") as AnimationPlayer
	if anim and anim.has_animation("idle"):
		anim.play("idle")

func update(_delta: float) -> void:
	var input_dir := Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)
	if input_dir != Vector2.ZERO:
		finished.emit("move")

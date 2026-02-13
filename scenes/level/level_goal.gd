class_name LevelGoal
extends Area2D
## Destination marker. Emits goal_reached when the player enters.

signal goal_reached()

var _pulse: float = 0.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	_pulse += delta * 3.0
	queue_redraw()

func _draw() -> void:
	var alpha := 0.4 + sin(_pulse) * 0.2
	draw_circle(Vector2.ZERO, 14.0, Color(0.2, 1.0, 0.3, alpha))
	draw_arc(Vector2.ZERO, 14.0, 0, TAU, 32, Color(1, 1, 1, 0.7), 1.5)
	# Small inner diamond
	var d := 5.0
	var diamond := PackedVector2Array([
		Vector2(0, -d), Vector2(d, 0), Vector2(0, d), Vector2(-d, 0)
	])
	draw_colored_polygon(diamond, Color(1, 1, 1, 0.9))

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		goal_reached.emit()

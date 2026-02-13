class_name RangeIndicator
extends Node2D
## Draws a translucent circle showing the tether range of the parent post.

@export var fill_color: Color = Color(0.3, 0.7, 1.0, 0.08)
@export var border_color: Color = Color(0.3, 0.7, 1.0, 0.3)
@export var border_width: float = 1.5

var _always_visible: bool = true

func _ready() -> void:
	# RangeIndicator is toggled visible/invisible for the range circle,
	# but we always want to draw the post dot. So we override visibility
	# by keeping the node always in the tree and checking parent state.
	_always_visible = true

func _process(_delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	var parent_post := get_parent() as TetherPost
	if not parent_post:
		return

	# Always draw the post center dot regardless of visibility
	var post_color := Color(0.4, 0.8, 1.0, 1.0) if parent_post.is_active else Color(0.5, 0.6, 0.7, 0.8)
	draw_circle(Vector2.ZERO, 5.0, post_color)
	draw_arc(Vector2.ZERO, 5.0, 0, TAU, 16, Color(1, 1, 1, 0.6), 1.0)

	# Only draw range circle when the post is active
	if not parent_post.is_active:
		return
	var radius: float = parent_post.tether_range
	draw_circle(Vector2.ZERO, radius, fill_color)
	draw_arc(Vector2.ZERO, radius, 0, TAU, 64, border_color, border_width)

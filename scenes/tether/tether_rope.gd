class_name TetherRope
extends Line2D
## Verlet rope that physically constrains the player.
## The rope has a fixed length. When taut, the player cannot move further.
## The rope IS the constraint — no invisible circle needed.

## Number of point masses along the rope
@export var point_count: int = 20

## No gravity for top-down view. The rope trails along the ground.
@export var rope_gravity: Vector2 = Vector2.ZERO

## Number of constraint solver iterations per physics frame.
## Higher = stiffer rope that doesn't stretch.
@export var constraint_iterations: int = 8

## Damping to reduce oscillation (0.99 = very slight damping)
@export var damping: float = 0.99

## The fixed total length of the rope in pixels.
## Set by initialize() from the tether post's tether_range.
var rope_length: float = 200.0
var segment_length: float = 0.0

var points_current: PackedVector2Array = []
var points_previous: PackedVector2Array = []

var anchor_node: Node2D = null
var target_node: Node2D = null

## After constraint solving, this is where the rope says the player should be.
## The TetherSystem reads this to correct the player's position.
var constrained_end_position: Vector2 = Vector2.ZERO

## True when the rope is fully taut and actively constraining the player.
var is_taut: bool = false

func initialize(post: Node2D, player: Node2D, length: float) -> void:
	anchor_node = post
	target_node = player
	rope_length = length
	segment_length = rope_length / float(point_count - 1)

	var start_pos: Vector2 = anchor_node.global_position
	var end_pos: Vector2 = target_node.global_position

	points_current.resize(point_count)
	points_previous.resize(point_count)

	# Place points along a straight line from anchor to player
	for i in range(point_count):
		var t: float = float(i) / float(point_count - 1)
		var pos: Vector2 = start_pos.lerp(end_pos, t)
		points_current[i] = pos
		points_previous[i] = pos

	constrained_end_position = end_pos

	# Line2D appearance
	width = 2.0
	default_color = Color(0.7, 0.85, 1.0, 0.9)
	joint_mode = Line2D.LINE_JOINT_ROUND
	begin_cap_mode = Line2D.LINE_CAP_ROUND
	end_cap_mode = Line2D.LINE_CAP_ROUND
	self.points = points_current

func _physics_process(delta: float) -> void:
	if not anchor_node or not target_node:
		return

	# Step 1: Verlet integration for free points (not endpoints)
	for i in range(1, point_count - 1):
		var current: Vector2 = points_current[i]
		var previous: Vector2 = points_previous[i]
		var vel: Vector2 = (current - previous) * damping

		points_previous[i] = current
		points_current[i] = current + vel + rope_gravity * delta * delta

	# Step 2: Pin the anchor end (always fixed to post)
	points_current[0] = anchor_node.global_position
	points_previous[0] = anchor_node.global_position

	# Step 3: Set the player end to where the player currently is.
	# The constraint solver will pull this back if the rope can't reach.
	points_current[point_count - 1] = target_node.global_position
	points_previous[point_count - 1] = target_node.global_position

	# Step 4: Solve distance constraints (Jakobsen method)
	# The anchor is pinned. The player end is FREE to be moved by constraints.
	for _iter in range(constraint_iterations):
		_solve_constraints()

	# Step 5: Re-pin anchor (it may drift during solving)
	points_current[0] = anchor_node.global_position

	# Step 6: Read out where the rope says the player end should be
	constrained_end_position = points_current[point_count - 1]

	# Check if the rope is taut (player endpoint was moved by constraints)
	var desired_end: Vector2 = target_node.global_position
	is_taut = constrained_end_position.distance_to(desired_end) > 1.0

	# Step 7: Update Line2D rendering
	self.points = points_current

func _solve_constraints() -> void:
	for i in range(point_count - 1):
		var p1: Vector2 = points_current[i]
		var p2: Vector2 = points_current[i + 1]
		var diff: Vector2 = p2 - p1
		var current_dist: float = diff.length()

		if current_dist < 0.001:
			continue

		var error: float = current_dist - segment_length
		var correction: Vector2 = diff.normalized() * error

		if i == 0:
			# Anchor is pinned — only move p2
			points_current[i + 1] -= correction
		else:
			# Both points are free — split correction equally
			# (the player endpoint is NOT pinned, so it gets moved too)
			points_current[i] += correction * 0.5
			points_current[i + 1] -= correction * 0.5

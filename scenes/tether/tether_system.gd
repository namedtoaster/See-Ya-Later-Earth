class_name TetherSystem
extends Node
## Manages tether connections between the player and posts.
## Uses distance checks (no collision shapes). The rope physics constrain the player.

signal tether_connected(post: TetherPost)
signal tether_disconnected(post: TetherPost)

@export var player_path: NodePath
@export var tether_rope_scene: PackedScene

var player: Player = null
var current_post: TetherPost = null
var nearby_post: TetherPost = null
var tether_rope: TetherRope = null
var all_posts: Array = []

func _ready() -> void:
	process_physics_priority = 1

	player = get_node(player_path) as Player
	if player:
		player.tether_system = self

	# Collect all posts after the tree is ready
	await get_tree().process_frame
	for node in get_tree().get_nodes_in_group("tether_posts"):
		if node is TetherPost:
			all_posts.append(node)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and nearby_post:
		connect_to_post(nearby_post)

func _physics_process(_delta: float) -> void:
	if not player:
		return

	# Check which post is closest and within interact range
	_update_nearby_post()

	# Let the rope constrain the player
	if current_post and tether_rope:
		if tether_rope.is_taut:
			player.global_position = tether_rope.constrained_end_position

			# Cancel outward velocity so player slides along boundary
			var away := player.global_position - current_post.global_position
			if away.length() > 0.1:
				var away_dir := away.normalized()
				var outward := player.velocity.dot(away_dir)
				if outward > 0:
					player.velocity -= away_dir * outward

func _update_nearby_post() -> void:
	var closest_post: TetherPost = null
	var closest_dist: float = INF

	for post in all_posts:
		var dist := player.global_position.distance_to(post.global_position)
		if dist < post.interact_radius and dist < closest_dist:
			closest_dist = dist
			closest_post = post

	nearby_post = closest_post

func connect_to_post(post: TetherPost) -> void:
	if current_post == post:
		return

	if current_post:
		current_post.set_active(false)
		tether_disconnected.emit(current_post)

	current_post = post
	current_post.set_active(true)
	tether_connected.emit(current_post)
	_update_rope()

func disconnect_from_post() -> void:
	if current_post:
		current_post.set_active(false)
		tether_disconnected.emit(current_post)
		current_post = null
	if tether_rope:
		tether_rope.queue_free()
		tether_rope = null

func _update_rope() -> void:
	if tether_rope:
		tether_rope.queue_free()
		tether_rope = null

	if current_post and tether_rope_scene:
		tether_rope = tether_rope_scene.instantiate() as TetherRope
		add_child(tether_rope)
		tether_rope.initialize(current_post, player, current_post.tether_range)

extends Node2D
## Test level with tether posts, oxygen, and a goal.
## Wires up all systems: HUD, tether, oxygen death/respawn, level completion.

@onready var player: Player = $Player
@onready var hud: HUD = $HUD
@onready var tether_system: TetherSystem = $TetherSystem
@onready var level_goal: LevelGoal = $LevelGoal
@onready var spawn_point: Marker2D = $SpawnPoint

func _ready() -> void:
	# Connect HUD to player signals
	hud.connect_to_player(player)

	# Connect oxygen death
	player.oxygen_depleted.connect(_on_oxygen_depleted)

	# Connect level goal
	level_goal.goal_reached.connect(_on_goal_reached)

	# Connect tether system for UI prompts
	tether_system.tether_connected.connect(_on_tether_connected)
	tether_system.tether_disconnected.connect(_on_tether_disconnected)

	# Auto-connect to first post (the ship/start)
	await get_tree().process_frame
	var start_post := $Posts/Post1 as TetherPost
	if start_post:
		tether_system.connect_to_post(start_post)

func _process(_delta: float) -> void:
	var sm := player.get_node_or_null("StateMachine") as StateMachine
	if sm and sm.current_state:
		hud.update_debug(sm.current_state.name)

	# Show interact prompt when near a post you're not connected to
	var near := tether_system.nearby_post
	hud.show_interact_prompt(near != null and near != tether_system.current_post)

func _on_oxygen_depleted() -> void:
	# Respawn player at start
	player.global_position = spawn_point.global_position
	player.current_oxygen = player.oxygen_data.max_oxygen
	player.is_dead = false
	player.oxygen_changed.emit(player.current_oxygen, player.oxygen_data.max_oxygen)

	# Reset all posts so oxygen can be collected again
	for post in tether_system.all_posts:
		post.oxygen_collected = false

	# Reconnect to first post
	var start_post := $Posts/Post1 as TetherPost
	if start_post:
		tether_system.connect_to_post(start_post)

func _on_goal_reached() -> void:
	GameManager.complete_level()

func _on_tether_connected(post: TetherPost) -> void:
	hud.show_interact_prompt(false)

	# Give one-time oxygen burst from this post
	var amount := post.collect_oxygen(player.oxygen_data.burst_amount)
	if amount > 0.0:
		player.receive_oxygen(amount)

func _on_tether_disconnected(_post: TetherPost) -> void:
	pass

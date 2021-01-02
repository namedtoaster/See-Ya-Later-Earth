# Saves and loads savegame files
# Each node is responsible for finding itself in the save_game
# dict so saves don't rely on the nodes' path or their source file
extends Node

const SaveGame = preload('res://SaveData/SaveGame.gd')
# TODO: Use project setting to save to res://debug vs user://
var SAVE_FOLDER: String = "res://SaveData/"
var SAVE_NAME_TEMPLATE: String = "save_%03d.tres"


func save(id: int, level_num: String):
	# Passes a SaveGame resource to all nodes to save data from
	# and writes it to the disk
	var save_game := SaveGame.new()
	save_game.game_version = ProjectSettings.get_setting("application/config/version")
	for node in get_tree().get_nodes_in_group('level_edit_save'):
		node.save(save_game)

	var directory: Directory = Directory.new()
	var NEW_SAVE_FOLDER = SAVE_FOLDER + level_num
	if not directory.dir_exists(NEW_SAVE_FOLDER):
		directory.make_dir_recursive(NEW_SAVE_FOLDER)

	var save_path = NEW_SAVE_FOLDER.plus_file(SAVE_NAME_TEMPLATE % id)
	var error: int = ResourceSaver.save(save_path, save_game)
	if error != OK:
		print('There was an issue writing the save %s to %s' % [id, save_path])


func load(id: int, level_num: String = ""):
	# Reads a saved game from the disk and delegates loading
	# to the individual nodes to load
	var NEW_SAVE_FOLDER = SAVE_FOLDER + level_num
	var save_file_path: String = NEW_SAVE_FOLDER.plus_file(SAVE_NAME_TEMPLATE % id)
	var file: File = File.new()
	if not file.file_exists(save_file_path):
		print("Save file %s doesn't exist" % save_file_path)
		return

	var save_game: Resource = load(save_file_path)
	for node in get_tree().get_nodes_in_group('level_edit_save'):
		node.load(save_game)

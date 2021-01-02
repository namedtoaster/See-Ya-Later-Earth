class_name Dialog
extends Node

onready var dialog
var dialog_array
var dialog_color
var dialog_names
var dialog_index = 0
var calling_node
var deactivate_player
var activate_player

# These variables will always be here and will just load whenever the node is loaded
onready var page = 0
onready var text = $Box/MarginContainer/Text
onready var status = false

# Writing here for test, then I'll move to base level class
#	one var with text
#		2d var, each index is one person/character
#			e.g. [["hello, how are you", "my name is robot"], ["hello robot, I'm the main character"]]
#	one var saying who starts the dialog (probably in an enum or something)
#		when sent to the dialog class, the color of the dialog box will dependent on who starts
#		possibility to do more than one character, but maybe it will just override the normal function?
#
#		maybe have another var that says how many characters are talking and what color their dialog box should be
#		at this point it would just make sense to make a class

# Functions
func _ready():	
	# Hide dialog box
	self.visible = false
	
	# Don't allow the user to click to the next page until the dialog box starts to fade in
	set_process_input(false)

func _input(_event):
	if Input.is_action_just_pressed("click") or Input.is_action_just_pressed("jump"):
		if text.get_visible_characters() > text.get_total_character_count():
			if page < dialog.size()-1:
				page += 1
				text.set_bbcode(dialog[page])
				text.set_visible_characters(0)
		else:
			text.set_visible_characters(text.get_total_character_count())
			
		if (text.get_visible_characters() > text.get_total_character_count()):
			if (page == dialog.size() - 1):
				dialog_index += 1
				if dialog_index < dialog_array.size():
					dialog = dialog_array[dialog_index]
					$Box/DialogColor.color = dialog_color[dialog_index]
					$Name.text = dialog_names[dialog_index]
					text.text = dialog[0]
					text.set_visible_characters(0)
					page = 0
				else:
					set_status(false)
				
func _process(_delta):
	var current_scene = get_tree().get_current_scene()
	if current_scene.intro_dialog != null:
		change_dialog_text("")
	set_process(false)
	
func set_player_movement(value):
	# TODO - might not be the best way to do this, might not. But it works for now
	# Right now, just deactivate the player so he can't move while the dialog is playing
	var player = get_tree().get_current_scene().get_node("World/Player")
	var state_machine = player.get_node("StateMachine")
	
	if (value):
		state_machine.initialize(state_machine.START_STATE)
		state_machine._change_state("idle")
		player.get_node("StateMachine").set_active(true)
	else:
		# Make sure the player is idling and not running or anything else
		state_machine._change_state("idle")
		# Set the player to inactive so they can't move around
		state_machine.set_active(false)

func set_status(value):
	status = value
	
	# If status is set to true, enable the node
	if (status):
		if deactivate_player:
			set_player_movement(false)
		
		# Set the text to the beginning of the dialog and hide all characters
		# and set the page back to 0
		text.text = dialog[0]
		text.set_visible_characters(0)
		page = 0
		
		# Start the start delay timer which enables several things
		$Box/Timers/StartDelay.start()
		
	if (!status):
		if activate_player:
			set_player_movement(true)
		
		# Fade out - should probably make sure the timer is greater than 1 second so the dialog box doesn't disappear while fading out
		$AnimationPlayer.play("fade_out")
		$Box/Timers/EndDelay.start()
		
		# Make sure all other timers are stopped
		$Box/Timers/StartDelay.stop()
		$Box/Timers/Timer.stop()
		
		# Stop processing input
		self.set_process_input(false)
		
		var current_scene = get_tree().get_current_scene()
		current_scene._on_dialog_exit_before_fade()
		

# It's assumed that every time you change the dialog text, you wish to show the dialog
# So after the text is updated, set the status to true
func change_dialog_text(path):
	# Set the calling dialog's path
	calling_node = get_node(path)
	
	# Set the delay for showing the ialog
	$Box/Timers/StartDelay.wait_time = max(0.001, calling_node.delay_start)
	
	# Run any "on_enter" functions for the dialogs in the scene
	var current_scene = get_tree().get_current_scene()
	current_scene._on_dialog_enter()
	
	# Set all other dialog properties
	dialog = calling_node.dialog_text[0]
	dialog_array = calling_node.dialog_text
	dialog_color = calling_node.dialog_color
	dialog_names = calling_node.names
	deactivate_player = calling_node.deactivate_player
	activate_player = calling_node.activate_player
	
	$Box/DialogColor.color = dialog_color[0]
	$Name.text = dialog_names[0]
	set_status(true)
	

func _on_Timer_timeout():
	text.set_visible_characters(text.get_visible_characters()+1)

func _on_StartDelay_timeout():
	# TODO
	# If the animation player isn't set to the first key of the fade in animation player in the editor,
	# the dialog box will flash before fading in
	# To prevent that, I just have the animation player set to the first frame on the fade in animation
	# for now. Not ideal, because if I want to do anything visually to the box in the editor, I'll have to
	# change the keyframe then reset it before I play. But it will do for now
	self.visible = true
	
	# Fade dialog in
	$AnimationPlayer.play("fade_in")
	set_process_input(true)
	$Box/Timers/Timer.start()
	
	# Regardless on if the player should be paused during the start delay, still pause him now
	set_player_movement(false)

func _on_EndDelay_timeout():
	var current_scene = get_tree().get_current_scene()
	current_scene._on_dialog_exit_after_fade()

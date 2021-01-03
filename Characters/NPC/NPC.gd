class_name NPC
extends Character

var dialog_text = null

export(float) var MULTIPLIER = 1.0

func _ready():
	speed.x = $StateMachine/Move.MAX_WALK_SPEED
	
func _attach_popup():
	$PopupLayer/Popup.popup_centered()
	
func _close_popup():
	$PopupLayer/Popup.visible = false

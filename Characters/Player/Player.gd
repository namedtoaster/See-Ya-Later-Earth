extends Character
var attached = false
var can_attach = false
	
func set_dead(value):
	$StateMachine.set_active(false)
	$AnimationPlayer.play("die")
	.set_dead(value)
	
	get_tree().get_current_scene().kill_player()
	
func _attach_popup():
	$BodyPivot/PopupLayer/Popup.popup_centered()
	
func _close_popup():
	$BodyPivot/PopupLayer/Popup.visible = false

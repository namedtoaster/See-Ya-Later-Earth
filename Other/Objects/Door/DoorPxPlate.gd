extends Node2D

export(String) var character = "Player"
var both_complete = false
var jet_complete = false
var bot_complete = false

var jet_left = false
var bot_left = false


func _on_DetectJet_body_entered(body):
	if body.name == "Player":
		jet_complete = true
		_check_complete()

func _on_DetectJet_body_exited(body):
	if body.name == "Player":
		jet_complete = false
		


func _on_DetectBot_body_entered(body):
	if body.name == "Robot":
		bot_complete = true
		_check_complete()


func _on_DetectBot_body_exited(body):
	if body.name == "Robot":
		bot_complete = false


func _on_WaitForDoorOpen_timeout():
	$AnimationPlayer.play("open")
	

func _check_complete():
	if jet_complete and bot_complete:
		$Timers/WaitForDoorOpen.start()
		
func _check_left():
	if jet_left and bot_left:
		$AnimationPlayer.play("close")

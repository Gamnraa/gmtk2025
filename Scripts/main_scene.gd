extends Node2D


func appear():
	$Player.show()
	$PlatR2.show()
	$Level.show()
	$DialogueBox.show()
	
func disappear():
	$Player.hide()
	$PlatR2.hide()
	$Level.hide()
	$DialogueBox.hide()
	
func _process(delta):
	if Global.playing: $Win2.hide()
	else:
		$Win2.show()
		disappear()
		Global.State = Global.REDGREENBLUE
		if Input.is_action_just_pressed("enter"): Global._ready()

func _on_lose_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.reset_player(false)


func _on_win_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.reset_player(true)

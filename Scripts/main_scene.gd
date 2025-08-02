extends Node2D


func _on_lose_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.reset_player(false)


func _on_win_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.reset_player(true)

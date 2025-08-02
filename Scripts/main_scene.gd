extends Node2D


func _on_lose_body_entered(body: Node2D) -> void:
	print(body, Global.ThePlayer)
	if body.name == "Player":
		Global.reset_player(false)

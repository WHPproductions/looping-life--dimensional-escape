extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.hide_player()


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.unhide_player()

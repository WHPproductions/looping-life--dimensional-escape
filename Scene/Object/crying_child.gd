extends Node2D

signal player_touched_child

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		emit_signal("player_touched_child")
		queue_free()

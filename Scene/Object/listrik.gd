extends Node2D

signal player_in_area

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Listrik.play()


func _on_listrik_area_body_entered(body: Node2D) -> void:
	if body is Player:
		body.kill_by_env()
		$ListrikArea.queue_free()
		$Listrik.stop()


func _on_listrik_area_body_exited(body: Node2D) -> void:
	pass # Replace with function body.

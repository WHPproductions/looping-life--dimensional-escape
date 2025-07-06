extends Node2D


# Called when the node enters the scene tree for the first time.
signal player_in_area

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Light.play()

func _on_light_area_body_entered(body: Node2D) -> void:
	if body is Player:
		#emit_signal("player_in_area")
		body.kill_by_light()
		$LightArea.queue_free()
		$Light.stop()
		$Light.visible = false

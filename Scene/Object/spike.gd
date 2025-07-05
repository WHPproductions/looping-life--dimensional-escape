extends Node2D

signal player_in_area

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Spike.play()

func _on_spike_area_body_entered(body: Node2D) -> void:
	if body is Player:
		$AudioSlashed.play()
		body.kill_by_env()
		$SpikeArea.queue_free()
		$Spike.stop()

func _on_spike_area_body_exited(body: Node2D) -> void:
	pass # Replace with function body.

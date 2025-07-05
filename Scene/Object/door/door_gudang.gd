extends Node2D

# Called when the node enters the scene tree for the first time.
signal player_in_area

func _on_door_gudang_area_body_entered(body: Node2D) -> void:
	if body is Player:
		emit_signal("player_in_area")
		
func door_open():
	$DoorGudang.play()
	$Delay.start()
	await $Delay.timeout #tunggu sebentar sampai pintu terbuka
	$DoorGudangArea.queue_free()
	$Blocking/DoorGudangCollision.queue_free()
	

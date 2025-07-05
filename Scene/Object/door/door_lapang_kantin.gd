extends Node2D

# Called when the node enters the scene tree for the first time.
signal player_in_area

func _ready():
	$StaticCollision.collision_layer = 100 #disable collision

func _on_door_lapang_kantin_area_body_entered(body: Node2D) -> void:
	if body is Player:
		emit_signal("player_in_area")
		
func door_open():
	$DoorLapangKantin.play()
	$Delay.start()
	await $Delay.timeout #tunggu sebentar sampai pintu terbuka
	$DoorLapangKantinArea.queue_free()
	$Blocking/DoorLapangKantinCollision.queue_free()
	$StaticCollision.collision_layer = 1  #enable collision

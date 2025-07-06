extends Node2D

signal player_in_area

func _ready():
	$StaticCollision.collision_layer = 100 #disable collision
	$LastDoorArea/CollisionShape2D.disabled = true #disable collision
		
func door_open():
	$LastDoor.play()
	$Delay.start()
	await $Delay.timeout #tunggu sebentar sampai pintu terbuka
	$LastDoorArea.queue_free()
	$Blocking/LastDoorCollision.queue_free()
	$StaticCollision.collision_layer = 1  #enable collision

func _on_last_door_area_body_entered(body: Node2D) -> void:
	if body is Player:
		emit_signal("player_in_area") 

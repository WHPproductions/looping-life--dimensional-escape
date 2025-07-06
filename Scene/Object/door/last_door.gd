extends Node2D

signal player_in_area

func _ready():
	$StaticCollision.collision_layer = 100 #disable collision
		
func door_open():
	$LastDoor.play()
	$Delay.start()
	await $Delay.timeout #tunggu sebentar sampai pintu terbuka
	$Blocking/LastDoorCollision.queue_free()
	$StaticCollision.collision_layer = 2  #enable collision

func _on_last_door_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		emit_signal("player_in_area") 

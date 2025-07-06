extends Node2D

# Called when the node enters the scene tree for the first time.
signal player_in_area

func _ready():
	$StaticCollision.collision_layer = 100 #disable collision

func _on_door_kantin_area_body_entered(body: Node2D) -> void:
	if body is Player:
		emit_signal("player_in_area")
		
func door_open():
	$DoorKantin.play()
	$Delay.start()
	await $Delay.timeout #tunggu sebentar sampai pintu terbuka
	$DoorKantinArea.queue_free()
	$Blocking/DoorKantinCollision.queue_free()
	$StaticCollision.collision_layer = 2  #enable collision

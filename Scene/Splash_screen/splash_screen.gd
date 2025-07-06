extends Control

func _ready():
	await get_tree().create_timer(3.0).timeout
	$Fade.fade("res://Scene/main_menu.tscn")
	

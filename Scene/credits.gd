extends Control


func _on_next_pressed() -> void:
	$Fade.fade("res://Scene/credit.tscn")


func _on_next_2_pressed() -> void:
	$Fade.fade("res://Scene/main_menu.tscn")

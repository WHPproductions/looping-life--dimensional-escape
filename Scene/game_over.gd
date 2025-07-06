extends CanvasLayer




func _on_restart_pressed() -> void:
	$Fade.fade("res://game.tscn")


func _on_main_menu_pressed() -> void:
	$Fade.fade("res://Scene/main_menu.tscn")

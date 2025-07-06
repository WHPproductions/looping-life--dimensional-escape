extends CanvasLayer


func _on_timer_timeout() -> void:
	$Fade.fade("res://Scene/main_menu.tscn")

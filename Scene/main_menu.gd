extends Control


func on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/main_world.tscn")


func _on_credit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/credits.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()

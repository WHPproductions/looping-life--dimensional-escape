extends Control

func _ready() -> void:
	$AnimationPlayer.play("menu_animation")

func on_start_pressed() -> void:
	if Globals.sudah_lihat_story:
		$Fade.fade("res://game.tscn")
	else:
		Globals.sudah_lihat_story = true
		$Fade.fade("res://Scene/story.tscn")

func _on_credit_pressed() -> void:
	$Fade.fade("res://Scene/credits.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()

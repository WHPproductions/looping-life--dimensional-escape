extends Control

func _ready() -> void:
	$AnimationPlayer.play("menu_animation")
	update_difficulty_ui()

func update_difficulty_ui() -> void:
	match Globals.kesulitan:
		0:
			%Start.text = "Start (Easy)"
			update_difficulties_style(%Mudah, Color(0, 1, 1, 1), 3)
		1:
			%Start.text = "Start (Normal)"
			update_difficulties_style(%Normal, Color(0, 1, 1, 1), 3)
		2:
			%Start.text = "Start (Hard)"
			update_difficulties_style(%Sulit, Color(0, 1, 1, 1), 3)


func update_difficulties_style(target_node: Control, color: Color, corner_radius: int = -1) -> void:
	var stylebox: StyleBoxFlat = target_node.get_theme_stylebox("normal", "Border").duplicate()
	stylebox.border_color = color  # Cyan color
	
	if corner_radius >= 0:
		stylebox.corner_radius_top_left = corner_radius
		stylebox.corner_radius_top_right = corner_radius
		stylebox.corner_radius_bottom_left = corner_radius
		stylebox.corner_radius_bottom_right = corner_radius
	
	target_node.add_theme_stylebox_override("normal", stylebox)

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

func _on_difficulty_pressed() -> void:
	update_difficulties_style(%Mudah, Color(1, 1, 1, 1), 3)
	update_difficulties_style(%Normal, Color(1, 1, 1, 1), 3)
	update_difficulties_style(%Sulit, Color(1, 1, 1, 1), 3)
	$Difficult.visible = true

func _on_mudah_pressed() -> void:
	Globals.kesulitan = 0
	$Difficult.visible = false
	update_difficulty_ui()

func _on_normal_pressed() -> void:
	Globals.kesulitan = 1
	$Difficult.visible = false
	update_difficulty_ui()

func _on_hard_pressed() -> void:
	Globals.kesulitan = 2
	$Difficult.visible = false
	update_difficulty_ui()

func _on_close_pressed() -> void:
	$Difficult.visible = false

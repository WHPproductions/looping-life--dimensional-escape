extends Node2D

@onready var fade = $Fade



func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	fade.fade("res://Scene/cooming_soon.tscn")

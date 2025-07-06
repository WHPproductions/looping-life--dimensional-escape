extends Node2D

@onready var heart = $CanvasLayer/heart
@onready var fade = $Fade

@export var shake = false

func _process(delta: float) -> void:
	if shake == true:
		heart.shake_heart(10, 5.5)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	fade.fade("res://game.tscn")

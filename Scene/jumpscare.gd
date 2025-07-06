extends CanvasLayer

func _ready() -> void:
	$AnimationPlayer.play("jumpscare")

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()

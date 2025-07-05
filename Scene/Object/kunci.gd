extends Node2D

signal player_in_area(kunci_value: String)  # Typed signal with parameter

@export var kunci := ""
@export var texture: Texture2D

func _ready() -> void:
	$Kunci.texture = texture

func _on_kunci_area_body_entered(body: Node2D) -> void:
	if body is Player:
		player_in_area.emit(kunci)  # New signal emit syntax
		$Kunci.visible = false
		$KunciArea.queue_free()

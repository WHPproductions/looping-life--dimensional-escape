extends Node2D

signal activated

var lights: int = 0

func _ready():
	%fire1.play()
	%fire2.play()
	%fire3.play()
	%fire4.play()

func increment_lights():
	lights += 1
	match lights:
		1:
			%AnimationPlayer.play("light_1_collected")
		2:
			%AnimationPlayer.play("light_2_collected")
		3:
			%AnimationPlayer.play("light_3_collected")
		4:
			%AnimationPlayer.play("light_4_collected")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		if lights >= 4:
			activate()


func activate():
		$SFX/Activated.play()
		$AnimationPlayer.play("activated")
		emit_signal("activated")

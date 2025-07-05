extends Node2D

signal activated

var lights: int = 0

func increment_lights():
	lights += 1
	match lights:
		1:
			$AnimatedSprite2D/Cahaya.visible = true
			$AnimatedSprite2D/Cahaya.play("default")
		2:
			$AnimatedSprite2D/Cahaya2.visible = true
			$AnimatedSprite2D/Cahaya2.play("default")
		3:
			$AnimatedSprite2D/Cahaya3.visible = true
			$AnimatedSprite2D/Cahaya3.play("default")
		4:
			$AnimatedSprite2D/Cahaya4.visible = true
			$AnimatedSprite2D/Cahaya4.play("default")
			$AnimationPlayer.play("activated")
			emit_signal("activated")

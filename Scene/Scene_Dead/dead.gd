extends CanvasLayer

@onready var heart = $heart
@onready var fade_normal = $heart/Fade

func _process(delta: float) -> void:
	if fade_normal.visible_canvas == true:
		visible = false
		fade_normal.visible_canvas = false

func dead_by_object():
	heart.dead_by_objects()
	heart.shake_heart(10, 5.5)
	visible = true

func dead_by_anomali():
	heart.dead_by_anomali()
	heart.shake_heart(10, 5.5)
	visible = true

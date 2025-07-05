extends CanvasLayer

var SceneString = ""
var play = false

var normal_fade = false
var visible_canvas = false
func _ready():
	SceneString = ""

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	if normal_fade == true:
		normal_fade = false
		$AnimationPlayer.play("fade")
		visible_canvas = true
	
	if play == true:
		var _c
		_c = get_tree().change_scene_to_file(SceneString)
		play = false

func fade(Scene : StringName):
	$AnimationPlayer.play_backwards("fade")
	SceneString = Scene
	play = true

func fade_normal():
	$AnimationPlayer.play_backwards("fade")
	normal_fade = true

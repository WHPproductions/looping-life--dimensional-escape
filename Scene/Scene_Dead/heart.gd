extends Node2D

@onready var animation = $AnimationPlayer
@onready var timer = $Timer
@onready var head = $head
@onready var fade = $Fade

var shake_intensity: float = 0.0
var active_shake_time: float = 0.0

var shake_decay: float = 5.0

var shake_time: float = 0.0
var shake_time_speed: float = 20.0

var noise = FastNoiseLite.new()

func _physics_process(delta: float) -> void:
	if active_shake_time > 0:
		shake_time += delta * shake_time_speed
		active_shake_time -= delta
		
		position = Vector2(
		noise.get_noise_2d(shake_time, 0) * shake_intensity,
		noise.get_noise_2d(0, shake_time) * shake_intensity
		)
		
		shake_intensity = max(shake_intensity - shake_decay * delta, 0)
	else:
		position = lerp(position, Vector2.ZERO, 10.5 * delta)

func shake_heart(intensity: int, time: float):
	randomize()
	noise.seed = randi()
	noise.frequency = 2.0
	
	shake_intensity = intensity
	active_shake_time = time
	shake_time = 0.0
	

func dead_by_objects():
	animation.play("dead_by_object")

func dead_by_anomali():
	animation.play("dead_by_alomani")
	timer.start()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "dead_by_object":
		fade.fade_normal()


func _on_head_animation_finished(anim_name: StringName) -> void:
	fade.fade("res://Scene/main_menu.tscn")


func _on_timer_timeout() -> void:
	animation.pause()
	head.play("head")

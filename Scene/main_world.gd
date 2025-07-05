extends Node2D

@onready var player: Player = %Player
@onready var camera: Camera2D = %Camera

const PLAYER_INITIAL_POSITION = Vector2(200, 1020)

func _ready() -> void:
	player.killed_by_env.connect(_on_player_killed_by_env)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_text_backspace"):
		player.kill_by_env()

func _on_player_killed_by_env() -> void:
	var new_player: PackedScene = load("res://Scene/Creature/player.tscn")
	
	player = new_player.instantiate()
	player.position = PLAYER_INITIAL_POSITION
	player.killed_by_env.connect(_on_player_killed_by_env)
	camera.reparent(player)
	camera.position = Vector2(0,0)
	add_child(player)

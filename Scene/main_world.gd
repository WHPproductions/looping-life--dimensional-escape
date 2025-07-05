extends Node2D

@onready var player: Player = %Player
@onready var camera: Camera2D = %Camera
@onready var dead = $Dead

var keys_inventory: Dictionary = {
	"kunci_lapangan" = false,
	"kunci_kantin" = false,
	"kunci_gudang" = false,
}
var light_inventory: int = 0

const PLAYER_INITIAL_POSITION = Vector2(200, 1020)

func _ready() -> void:
	# Mengkoneksi signal jika player mati
	player.killed_by_env.connect(_on_player_killed_by_env)
	player.killed_by_enemy.connect(_on_player_killed_by_enemy)


func _input(event: InputEvent) -> void:
	
	# kalau pencet backspace, bakal ngebunuh si player
	if event.is_action_pressed("ui_text_backspace") and OS.is_debug_build():
		player.kill_by_env()

func _on_player_killed_by_env() -> void:
	var new_player: PackedScene = load("res://Scene/Creature/player.tscn")
	player = new_player.instantiate()
	player.position = PLAYER_INITIAL_POSITION
	player.killed_by_env.connect(_on_player_killed_by_env)
	%Timers/PlayerKilledByEnv.start()
	await $Timers/PlayerKilledByEnv.timeout
	camera.reparent(player)
	camera.position = Vector2(0,0)
	add_child(player)

func _on_player_killed_by_enemy() -> void:
	pass

## Player mengambil kunci
func _on_kunci_player_in_area(kunci_value: String) -> void:
	keys_inventory[kunci_value] = true


# Nunggu signal dari Surya
func on_light_player_in_area() -> void:
	light_inventory += 1


func _on_lingkaran_sihir_activated() -> void:
	pass # Replace with function body.

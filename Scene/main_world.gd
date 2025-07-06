extends Node2D

@onready var player: Player = %Player
@onready var enemy: Enemy = %Enemy
@onready var camera: Camera2D = %Camera
@onready var flashlight: PointLight2D = %Flashlight

#region Progress Story Signals (Untuk adegan di parent)

var adegan_awal_belum := true
var terbunuh_pertama_belum := true
var koleksi_light_pertama_belum := true
var lingkaran_teraktivasi_belum := true
var lingkaran_sudah_aktivasi_dan_player_bundir_belum := true

signal adegan_awal
signal terbunuh_pertama
signal koleksi_light_pertama
signal lingkaran_teraktivasi
signal lingkaran_sudah_aktivasi_dan_player_bundir

#endregion

var keys_inventory: Dictionary = {
	"kunci_lapangan" = false,
	"kunci_kantin" = false,
	"kunci_gudang" = false,
}
var light_inventory: int = 0

var is_player_can_kill_herself := false

const PLAYER_INITIAL_POSITION = Vector2(200, 1020)

func _ready() -> void:
	# Mulai adegan awal
	if adegan_awal_belum:
		emit_signal("adegan_awal")
		adegan_awal_belum = false
	
	# Mengkoneksi signal jika player mati
	player.killed_by_env.connect(_on_player_killed_by_env)
	player.killed_by_light.connect(_on_light_player_in_area)
	enemy.player_killed.connect(_on_player_killed_by_enemy)

func _input(event: InputEvent) -> void:
	
	if Input.is_action_just_pressed("main_menu"):
		$DeadScene/heart/Fade.fade("res://Scene/main_menu.tscn")
	
	# kalau pencet backspace, bakal ngebunuh si player.
	if event.is_action_pressed("ui_accept") and is_player_can_kill_herself:
		player.kill_by_env()
		$Object/LastDoor.queue_free()
		
		# Mulai adegan
		if lingkaran_sudah_aktivasi_dan_player_bundir_belum:
			lingkaran_sudah_aktivasi_dan_player_bundir_belum = false
			await $Timers/PlayerKilledByEnv.timeout
			emit_signal("lingkaran_sudah_aktivasi_dan_player_bundir")

func _on_player_killed_by_env() -> void:
	# Menginisialisasi player baru
	var new_player: PackedScene = load("res://Scene/Creature/player.tscn")
	player = new_player.instantiate()
	player.position = PLAYER_INITIAL_POSITION
	player.killed_by_env.connect(_on_player_killed_by_env)
	enemy.player_killed.connect(_on_player_killed_by_enemy)
	player.killed_by_light.connect(_on_light_player_in_area)
	
	# Memberhentikan musik
	$SFX/Ambience.stream_paused = true
	
	# Memulai scene mati
	%DeadScene.dead_by_object()
	%Timers/PlayerKilledByEnv.start()
	await $Timers/PlayerKilledByEnv.timeout
	
	# Memulaikan musik
	$SFX/Ambience.stream_paused = false
	
	# Kamera kembali ke player dan player menjadi child
	camera.reparent(player)
	camera.position = Vector2.ZERO
	var new_flashlight: PointLight2D = flashlight.duplicate()
	player.add_child(new_flashlight)
	add_child(player)
	
	# Memulai adegan
	if terbunuh_pertama_belum:
		emit_signal("terbunuh_pertama")
		terbunuh_pertama_belum = false

func _on_player_killed_by_enemy() -> void:
	player.player_dead = true
	player.collision.queue_free()
	$SFX/Ambience.playing = false
	%DeadScene.dead_by_anomali()

## Player mengambil kunci
func _on_kunci_player_in_area(kunci_value: String) -> void:
	$SFX/KeyObtained.play()
	keys_inventory[kunci_value] = true

## Player mengambil light
func _on_light_player_in_area() -> void:
	# Menambah inventory light
	light_inventory += 1
	
	# Memutarkan Suara
	$SFX/LightObtained.play()
	
	# Menginisialisasi player baru
	var new_player: PackedScene = load("res://Scene/Creature/player.tscn")
	player = new_player.instantiate()
	player.position = PLAYER_INITIAL_POSITION
	player.killed_by_env.connect(_on_player_killed_by_env)
	player.killed_by_light.connect(_on_light_player_in_area)
	enemy.player_killed.connect(_on_player_killed_by_enemy)
	
	# Memberhentikan musik
	$SFX/Ambience.stream_paused = true
	
	# Memutar scene mati
	%DeadScene.dead_by_object()
	%Timers/PlayerKilledByEnv.start()
	await $Timers/PlayerKilledByEnv.timeout
	
	# Memutar scene lampu
	camera.reparent(%LingkaranSihir)
	camera.position = Vector2.ZERO
	$Timers/PlayerCollectedLight.start()
	%LingkaranSihir.increment_lights()
	await $Timers/PlayerCollectedLight.timeout
	
	# Memutar lagu lagi
	$SFX/Ambience.stream_paused = false
	
	# Kamera kembali ke player dan player menjadi child
	add_child(player)
	camera.reparent(player)
	camera.position = Vector2.ZERO
	var new_flashlight: PointLight2D = flashlight.duplicate()
	player.add_child(new_flashlight)
	
	# Mulai adegan
	if koleksi_light_pertama_belum:
		emit_signal("koleksi_light_pertama")
		koleksi_light_pertama_belum = false

func _on_lingkaran_sihir_activated() -> void:
	is_player_can_kill_herself = true
	if lingkaran_teraktivasi_belum:
		lingkaran_teraktivasi_belum = false
		emit_signal("lingkaran_teraktivasi")

func _on_last_door_player_in_area() -> void:
	#print("DETECTED")
	#$SFX/DoorOpened.play()
	#%LastDoor.door_open()
	pass

func _on_door_gudang_player_in_area() -> void:
	if keys_inventory["kunci_gudang"]:
		$SFX/DoorOpened.play()
		%DoorGudang.door_open()

func _on_door_kantin_player_in_area() -> void:
	if keys_inventory["kunci_kantin"]:
		$SFX/DoorOpened.play()
		%DoorKantin.door_open()
		
func _on_door_lapang_player_in_area() -> void:
	if keys_inventory["kunci_lapangan"]:
		$SFX/DoorOpened.play()
		%DoorLapang.door_open()

func _on_door_lapang_kantin_player_in_area() -> void:
	if keys_inventory["kunci_lapangan"]:
		$SFX/DoorOpened.play()
		%DoorLapangKantin.door_open()

## Untuk Jumpscare
func _on_crying_child_player_touched_child() -> void:
	var jumpscare = load("res://Scene/jumpscare.tscn").instantiate()
	add_child(jumpscare)
	%Timers/PlayerJumpscared.start()
	$SFX/Ambience.stream_paused = true
	await $Timers/PlayerJumpscared.timeout
	$SFX/Ambience.stream_paused = false

class_name Enemy
extends CharacterBody2D

signal player_killed

enum State {
	IDLE,
	MOVING,
}

@export var speed: int = 100

var player: Player = null
var player_in_area := false
var state: State
var random_direction := Vector2.ZERO
var state_timer: float = 0.0

const MOVE_DURATION := 2.0
const IDLE_DURATION := 1.0

func _ready() -> void:
	randomize()
	random_direction = get_random_direction()
	state = State.MOVING
	state_timer = MOVE_DURATION

func _physics_process(delta: float) -> void:
	if player:
		if player.player_dead:
			$PlayerDetector/CollisionShape2D.disabled = true
			velocity = Vector2.ZERO
			move_and_slide()
			return
	else:
		$PlayerDetector/CollisionShape2D.disabled = false
	
	if (player 
		and player_in_area
		and can_see_player() 
		and not player.player_dead
		):
		var direction: Vector2 = (player.global_position - global_position).normalized()
		velocity = direction * speed
	else:
		handle_random_movement(delta)
	
	# Play animation
	if velocity != Vector2.ZERO:
		%AnimatedSprite2D.play("moving")
	else:
		%AnimatedSprite2D.play("idle")
	
	
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
	
	move_and_slide()

func handle_random_movement(delta: float) -> void:
	state_timer -= delta
	
	if state == State.MOVING:
		velocity = random_direction * speed
		
		if state_timer <= 0:
			state = State.IDLE
			state_timer = IDLE_DURATION
			velocity = Vector2.ZERO
	
	elif state == State.IDLE:
		velocity = Vector2.ZERO
	
		if state_timer <= 0:
			state = State.MOVING
			state_timer = MOVE_DURATION
			random_direction = get_random_direction()

func get_random_direction() -> Vector2:
	var angle: float = randf_range(0, TAU)
	return Vector2(cos(angle), sin(angle)).normalized()

func can_see_player() -> bool:
	var ray: RayCast2D = $PlayerRaycast
	
	# Kalau player tersembunyi
	if ray == null or player == null or player.is_currently_hidden:
		return false
	
	var to_player: Vector2 = (player.global_position - global_position).normalized()
	ray.target_position = to_player * 550  # make sure it reaches past the player
	ray.force_raycast_update()
	
	if ray.is_colliding():
		var hit: Object = ray.get_collider()
		#print("Ray hit: ", hit.name, " | Type: ", hit.get_class())
		if hit is Player or hit.get_parent() is Player:
			#print("✔ Player detected!")
			return true
	return false


func _on_player_detector_body_entered(body: Node2D) -> void:
	if body is Player:
		player_in_area = true
		player = body as Player


func _on_player_detector_body_exited(body: Node2D) -> void:
	if body is Player:
		player_in_area = false
		player = null


func _on_kill_player_area_body_entered(body: Node2D) -> void:
	if body is Player:
		$AudioStreamPlayer2D.playing = false
		%SFX/PlayerKilled.play()
		emit_signal("player_killed")

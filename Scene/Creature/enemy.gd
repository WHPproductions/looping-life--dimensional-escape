class_name Enemy
extends CharacterBody2D

enum State {
	IDLE,
	MOVING,
}

@export var speed: int = 100
@export var health: int = 1

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
	if dead:
		$EnemyFollowArea/enemy_follow_area.disabled = true
		velocity = Vector2.ZERO
		move_and_slide()
		return
	else:
		$EnemyFollowArea/enemy_follow_area.disabled = false

	if player_in_area and player and can_see_player() and not player_dead:
		var direction: Vector2 = (player.global_position - global_position).normalized()
		velocity = direction * speed
	else:
		handle_random_movement(delta)

	move_and_slide()

func handle_random_movement(delta: float) -> void:
	state_timer -= delta

	if state == State.MOVING:
		velocity = random_direction * speed

		if state_timer <= 0:
			state = State.
			state_timer = IDLE_DURATION
			velocity = Vector2.ZERO

	elif state == "idle":
		velocity = Vector2.ZERO

		if state_timer <= 0:
			state = "moving"
			state_timer = MOVE_DURATION
			random_direction = get_random_direction()

func get_random_direction() -> Vector2:
	var angle: float = randf_range(0, TAU)
	return Vector2(cos(angle), sin(angle)).normalized()

func can_see_player() -> bool:
	var ray: RayCast2D = $PlayerRaycast
	if ray == null or player == null:
		return false

	var to_player: Vector2 = (player.global_position - global_position).normalized()
	ray.target_position = to_player * 550  # make sure it reaches past the player
	ray.force_raycast_update()

	if ray.is_colliding():
		var hit: Object = ray.get_collider()
		#print("Ray hit: ", hit.name, " | Type: ", hit.get_class())
		if hit == player or hit.get_parent() == player:
			#print("✔ Player detected!")
			return true
	return false


func _on_enemy_follow_area_body_entered(body: Node) -> void:
	if body.has_method("player"):
		player_in_area = true
		player = body as CharacterBody2D

func _on_enemy_follow_area_body_exited(body: Node) -> void:
	if body.has_method("player"):
		player_in_area = false
		player = null

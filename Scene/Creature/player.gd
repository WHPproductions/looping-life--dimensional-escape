class_name Player
extends CharacterBody2D

# Signal untuk player tersembunyi. Sebenarnya bisa sama is_currently_hidden aja sih
signal player_hidden
signal player_unhidden
signal killed_by_env
signal killed_by_enemy

var input := Vector2.ZERO
var played_dead_animation := false
var player_speed: int = 150
var player_dead := true
var is_currently_hidden := false

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	anim.play("idle")

func _physics_process(_delta: float) -> void:
	var input_vector: Vector2 = get_input()
	
	if input_vector != Vector2.ZERO:
		velocity = input_vector * player_speed
		
		# Flip the sprite based on direction
		if input_vector.x != 0:
			anim.scale.x = abs(anim.scale.x) * sign(input_vector.x)
		
		anim.play("walk")
	else:
		velocity = Vector2.ZERO
		if player_dead:
			if !played_dead_animation:
				anim.play("dead")
				played_dead_animation = true
		else:
			anim.play("idle")

	move_and_slide()

func get_input() -> Vector2:
	var input := Vector2.ZERO
	if !player_dead:
		input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
		input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return input.normalized()

## Menyembunyikan si Player
func hide_player() -> void:
	modulate = Color(1, 1, 1, 0.5)
	is_currently_hidden = true
	emit_signal("player_hidden")

## Mereveal si Player
func unhide_player() -> void:
	modulate = Color(1, 1, 1, 1)
	is_currently_hidden = false
	emit_signal("player_unhidden")

## Bunuh player sama environment
func kill_by_env() -> void:
	player_dead = true
	emit_signal("killed_by_env")

## Bunuh player sama Enemy
func kill_by_enemy() -> void:
	player_dead = true
	emit_signal("killed_by_enemy")

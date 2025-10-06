class_name PlayerMeleAttack extends PlayerState

@onready var run: PlayerRun = $"../Run"
@onready var idle: PlayerIdle = $"../Idle"
@export_range(1, 20, 0.5) var decelerate_speed : float = 3

var is_attacking : bool = false

func enter():
	player.set_animation("mele_attack")
	is_attacking = true

func exit():
	pass

func update(delta) -> PlayerState:
	player.velocity -= player.velocity * decelerate_speed * delta
	
	if is_attacking:
		return null
	
	if player.direction == Vector2.ZERO:
		return idle
	else:
		return run

func physics_update(delta) -> PlayerState:
	return null

func handle_input(event : InputEvent) -> PlayerState:
	return null

# called from AnimatorPlayer
func _attack_finished():
	is_attacking = false

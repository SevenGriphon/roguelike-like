class_name PlayerIdle extends PlayerState

@onready var run: PlayerRun = $"../Run"
@onready var mele_attack: PlayerMeleAttack = $"../MeleAttack"

func enter():
	player.set_animation("idle")

func exit():
	pass

func update(delta) -> PlayerState:
	if player.direction != Vector2.ZERO:
		return run
	player.velocity = Vector2.ZERO
	return null

func physics_update(delta) -> PlayerState:
	return null

func handle_input(event : InputEvent) -> PlayerState:
	if event.is_action_pressed("mele_attack"):
		return mele_attack
	return null

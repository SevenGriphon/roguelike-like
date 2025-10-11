class_name PlayerRangeAttack extends PlayerState

@onready var run: PlayerRun = $"../Run"
@onready var idle: PlayerIdle = $"../Idle"

func enter():
	player.current_weapon.enter(player)

func exit():
	player.current_weapon.exit()

func update(delta) -> PlayerState:
	if player.current_weapon.update(delta):
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return run
	
	return null

func physics_update(delta) -> PlayerState:
	return player.current_weapon.physics_update(delta)

func handle_input(event : InputEvent) -> PlayerState:
	return player.current_weapon.handle_input(event)

class_name PlayerAttack extends PlayerState

@onready var run: PlayerRun = $"../Run"
@onready var idle: PlayerIdle = $"../Idle"

signal animation_event(event_name)

func enter():
	player.current_weapon.enter(player, animation_event)

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

func _on_animation_event(event_name):
	animation_event.emit(event_name)

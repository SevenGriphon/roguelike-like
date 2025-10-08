class_name PlayerDamaged extends PlayerState

@onready var run: PlayerRun = $"../Run"
@onready var idle: PlayerIdle = $"../Idle"

var anim_playing : bool = false

func enter():
	player.set_animation("hurt")
	anim_playing = true

func exit():
	pass

func update(delta) -> PlayerState:
	if anim_playing:
		return null
	
	if player.direction == Vector2.ZERO:
		return idle
	else:
		return run

func physics_update(delta) -> PlayerState:
	return null

func _anim_finished():
	anim_playing = false

func _on_player_damaged() -> void:
	state_machine.change_state(self)

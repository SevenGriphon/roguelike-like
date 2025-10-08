class_name PlayerDead extends PlayerState

func enter():
	player.set_animation("dead")

func exit():
	pass

func update(delta) -> PlayerState:
	return null

func physics_update(delta) -> PlayerState:
	return null

func _anim_finished():
	player.queue_free()

func _on_player_character_dead() -> void:
	state_machine.change_state(self)

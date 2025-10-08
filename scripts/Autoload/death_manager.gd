extends Node

var player : Player

func set_player(new_player : Player):
	player = new_player
	player.dead.connect(func():
		call_deferred("_on_player_death"))

func _on_player_death():
	get_tree().reload_current_scene()

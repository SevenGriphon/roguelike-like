extends Node

@export var orc_tscn :PackedScene
@export var marker_tscn :PackedScene
@export var min_spawn_time = 10
@export var max_spawn_time = 30
var wave = 0
var alive_enemies : int

func start_new_wave() -> void:
	return
	wave += 1
	for enemy in range(wave*3):
		prepare_to_spawn_enemy()

func prepare_to_spawn_enemy():
	var marker :Node2D = marker_tscn.instantiate()
	get_tree().current_scene.add_child.call_deferred(marker)
	
	var x_pos = randf_range(0, get_viewport().size.x)
	var y_pos = randf_range(0, get_viewport().size.y)
	var position = Vector2(x_pos, y_pos)
	marker.position = position
	
	var delay_timer :Timer = marker.get_node("Timer")
	delay_timer.connect("timeout", func(): # connecting enemy spawning to timer timeout
		spawn_enemy(position, marker)
	)

func spawn_enemy(position, marker :Node2D):
	marker.queue_free()
	
	var orc :CharacterBody2D = orc_tscn.instantiate()
	orc.position = position
	get_tree().current_scene.add_child(orc)
	
	orc.died.connect(func():
		alive_enemies -= 1
		if alive_enemies <= 0:
			start_new_wave()
	)
	alive_enemies += 1

func _ready() -> void:
	start_new_wave()

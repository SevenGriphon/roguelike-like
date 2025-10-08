extends Node

@export var orc_tscn :PackedScene
@export var marker_tscn :PackedScene
@export var min_spawn_time = 10
@export var max_spawn_time = 30
@export var tilemap : TileMapLayer

var wave = 0
var alive_enemies : int
var wave_enemies : Array = []

func _ready() -> void:
	start_new_wave()

func start_new_wave() -> void:
	#return
	wave += 1
	var valid_positions = get_valid_spawn_positions()
	queue_enemies(wave*3, valid_positions)
	await get_tree().create_timer(1).timeout
	spawn_enemies()

func get_valid_spawn_positions() -> Array:
	var valid_pos = []
	for pos in tilemap.get_used_cells():
		var tile_data = tilemap.get_cell_tile_data(pos)
		if tile_data.get_custom_data("can_spawn"):
			var local_pos = tilemap.map_to_local(pos)
			valid_pos.append(tilemap.to_global(local_pos))
	return valid_pos


func queue_enemies(amount : int, positions : Array):
	wave_enemies = []
	for i in range(amount):
		var enemy_pos = positions[randi_range(0, len(positions))]
		
		var marker :Node2D = marker_tscn.instantiate()
		get_tree().current_scene.add_child.call_deferred(marker)
		
		marker.position = enemy_pos
		var enemy_info : Dictionary = {
			"position": enemy_pos,
			"marker": marker,
		}
		
		wave_enemies.append(enemy_info)

func spawn_enemies():
	for enemy_info in wave_enemies:
		enemy_info.marker.queue_free()
		
		var orc :CharacterBody2D = orc_tscn.instantiate()
		orc.position = enemy_info.position
		get_tree().current_scene.add_child(orc)
		
		orc.died.connect(func():
			alive_enemies -= 1
			if alive_enemies <= 0:
				start_new_wave()
		)
		alive_enemies += 1

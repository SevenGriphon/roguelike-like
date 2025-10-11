extends Node2D

@onready var label :Label = $Label
@onready var player :Player = get_tree().get_first_node_in_group("Player")

var active_areas :Array[InteractionArea] = []
var can_interact = true

func register_area(area):
	active_areas.append(area)

func unregister_area(area):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)

func _process(delta: float) -> void:
	if can_interact and active_areas.size() > 0:
		active_areas.sort_custom(_sort_by_distance)
		label.text = "[E] to " + active_areas[0].action_text
		label.global_position = active_areas[0].global_position
		label.global_position.x -= label.size.x / 2
		label.global_position.y -= 36
		label.show()
	else:
		label.hide()

func _sort_by_distance(area1 :Area2D, area2 :Area2D):
	var dist_to_area1 = area1.global_position.distance_to(player.global_position)
	var dist_to_area2 = area2.global_position.distance_to(player.global_position)
	return dist_to_area1 < dist_to_area2

func _input(event: InputEvent) -> void:
	if can_interact and event.is_action_pressed("interact"):
		if active_areas.size() > 0:
			active_areas[0].on_interact.call()

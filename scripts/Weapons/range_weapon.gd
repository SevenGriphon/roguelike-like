class_name RangeWeapon extends Weapon

@export var arrow_tscn :PackedScene

var attack :bool
var player :Player

func enter(_player):
	player = _player
	player.set_animation("range_attack")
	attack = true
	player.velocity = Vector2.ZERO

func exit():
	pass

func update(delta) -> bool:
	return !attack

func physics_update(delta) -> PlayerState:
	return null

func handle_input(event : InputEvent) -> PlayerState:
	return null

func fire_arrow():
	var mouse_angle = player.get_local_mouse_position().angle()
	var arrow :Node2D = arrow_tscn.instantiate()
	arrow.rotation = mouse_angle
	arrow.position = player.position + player.attack_pivot.position
	get_tree().current_scene.add_child(arrow)

func _attack_finished(anim_name: StringName) -> void:
	attack = false

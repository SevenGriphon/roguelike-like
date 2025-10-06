class_name PlayerRangeAttack extends PlayerState

@export var arrow_tscn : PackedScene
@onready var idle : PlayerIdle = $"../Idle"
@onready var run : PlayerRun = $"../Run"

var attack = false

func enter():
	player.set_animation("range_attack")
	attack = true
	player.velocity = Vector2.ZERO

func exit():
	pass

func update(delta) -> PlayerState:
	if !attack:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return run
	return null

func physics_update(delta) -> PlayerState:
	return null

func handle_input(event : InputEvent) -> PlayerState:
	return null

func fire_arrow():
	var mouse_angle = player.get_local_mouse_position().angle()
	var arrow :Area2D = arrow_tscn.instantiate()
	arrow.rotation = mouse_angle
	arrow.position = player.position + player.attack_pivot.position
	get_tree().current_scene.add_child(arrow)


func _attack_finished(anim_name: StringName) -> void:
	attack = false

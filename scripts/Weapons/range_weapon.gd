class_name RangeWeapon extends Weapon

@export var arrow_tscn :PackedScene

var attack :bool

func enter(_player, _animation_event : Signal):
	super(_player, _animation_event)
	attack = true
	player.set_animation("range_attack")
	player.velocity = Vector2.ZERO


func update(delta) -> bool:
	return !attack

func physics_update(delta) -> PlayerState:
	return null

func handle_input(event : InputEvent) -> PlayerState:
	return null
	
func exit():
	super()

func _fire_arrow():
	var mouse_angle = player.get_local_mouse_position().angle()
	var arrow :Node2D = arrow_tscn.instantiate()
	arrow.rotation = mouse_angle
	arrow.position = player.position + player.attack_pivot.position
	get_tree().current_scene.add_child(arrow)

func _attack_finished() -> void:
	attack = false

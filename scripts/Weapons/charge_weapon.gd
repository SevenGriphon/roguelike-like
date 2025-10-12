class_name ChargeWeapon extends Weapon

@export var arrow_tscn : PackedScene
@export_category("Damage")
@export var max_damage :int = 100
@export var base_damage :int = 30
@export var damage_increment :int = 80

var attack :bool
var charged :bool
var already_shot :bool
var damage :float

func enter(_player, _animation_event):
	super(_player, _animation_event)
	attack = true
	charged = false
	already_shot = false
	damage = base_damage
	player.set_animation("charge_attack")
	player.velocity = Vector2.ZERO


func update(delta) -> bool:
	if !already_shot and charged and !Input.is_action_pressed("attack"):
		already_shot = true
		player.animation_player.play("charge_attack")
		fire_arrow()
	
	if !already_shot and charged and Input.is_action_pressed("attack"):
		damage = min(damage + damage_increment * delta, max_damage)
	
	if !charged and !Input.is_action_pressed("attack"):
		attack = false
	
	return !attack

func physics_update(delta) -> PlayerState:
	return null

func handle_input(event : InputEvent) -> PlayerState:
	return null
	
func exit():
	super()

func fire_arrow():
	var mouse_angle = player.get_local_mouse_position().angle()
	var arrow :Arrow = arrow_tscn.instantiate()
	arrow.hurtbox.damage = damage
	arrow.rotation = mouse_angle
	arrow.position = player.position + player.attack_pivot.position
	get_tree().current_scene.add_child(arrow)

func _charged():
	charged = true
	player.animation_player.pause()

func _attack_finished():
	attack = false

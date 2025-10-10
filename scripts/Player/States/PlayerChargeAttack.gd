class_name PlayerChargeAttack extends PlayerState

@export var arrow_tscn : PackedScene
@onready var idle : PlayerIdle = $"../Idle"
@onready var run : PlayerRun = $"../Run"

var attack :bool
var charged :bool
var already_shot : bool

func enter():
	player.set_animation("charge_attack")
	attack = true
	charged = false
	already_shot = false
	player.velocity = Vector2.ZERO

func exit():
	pass

func update(delta) -> PlayerState:
	if !already_shot and charged and !Input.is_action_pressed("attack"):
		already_shot = true
		player.animation_player.play("charge_attack")
		fire_arrow()
	elif !charged and !Input.is_action_pressed("attack"):
		attack = false
	
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
	var arrow :Node2D = arrow_tscn.instantiate()
	arrow.rotation = mouse_angle
	arrow.position = player.position + player.attack_pivot.position
	get_tree().current_scene.add_child(arrow)

func _charged():
	charged = true
	player.animation_player.pause()

func _attack_finished():
	print("attacked")
	attack = false

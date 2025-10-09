class_name PlayerRun extends PlayerState

@export var speed = 150
@onready var idle: PlayerIdle = $"../Idle"
@onready var mele_attack: PlayerMeleAttack = $"../MeleAttack"
@onready var range_attack: PlayerRangeAttack = $"../RangeAttack"

func enter():
	player.set_animation("run")

func exit():
	player.velocity = Vector2.ZERO

func update(delta) -> PlayerState:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * speed
	return null

func physics_update(delta) -> PlayerState:
	return null

func handle_input(event : InputEvent) -> PlayerState:
	if event.is_action_pressed("mele_attack"):
		return mele_attack
	if event.is_action_pressed("attack"):
		return range_attack
	return null

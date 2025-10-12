class_name Player extends CharacterBody2D

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var anim_sprite = $AnimatedSprite2D
@onready var attack_pivot = $AttackPivot
@export var player_state_machine : PlayerStateMachine
@export var health = 250
@export var starting_weapon :WeaponData

signal damaged()
signal dead()

var current_weapon : Weapon
var direction : Vector2
var invulnerable :bool = false

func set_animation(animation : String):
	animation_player.play(animation)

func _ready() -> void:
	player_state_machine.initiate(self)
	DeathManager.set_player(self)
	change_weapon(starting_weapon)

func _process(delta: float) -> void:
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	direction = direction.normalized()
	var mouseAngle = rad_to_deg(get_local_mouse_position().angle())
	anim_sprite.flip_h = abs(mouseAngle) > 90
	attack_pivot.scale.x = -1 if abs(mouseAngle) > 90 else 1

func _physics_process(delta: float) -> void:
	move_and_slide()

func _on_damaged(damage: Variant) -> void:
	if invulnerable:
		return
	
	health -= damage
	if health > 0:
		damaged.emit()
	else:
		dead.emit()

func change_weapon(weapon_data :WeaponData):
	current_weapon = weapon_data.weapon_script.new()
	current_weapon.init(self, weapon_data)

extends  State
class_name EnemyFollow

@export var enemy : Enemy
@export var anim_sprite : AnimatedSprite2D
@export var speed = 100
@export var agro_label : AgroLabel
var player :CharacterBody2D

func enter():
	if !enemy.sees_player:
		agro_label.appear()
	enemy.sees_player = true
	player = get_tree().get_first_node_in_group("Player")

func follow_player(ignore_distance = false):
	if !player:
		state_transition.emit(self, "Idle")
		return
	if enemy:
		var player_direction = (player.position - enemy.position)
		if player_direction.length() < 350 or ignore_distance:
			if player_direction.length() > 150:
				enemy.velocity = player_direction.normalized() * speed
			else:
				#enemy.velocity = Vector2.ZERO
				state_transition.emit(self, "Attack")
		else:
			state_transition.emit(self, "Idle")

func physics_update(delta):
	follow_player()

func update(delta):
	if enemy.velocity.length():
		anim_sprite.play("run")
	else:
		anim_sprite.play("idle")

func exit():
	enemy.velocity = Vector2.ZERO

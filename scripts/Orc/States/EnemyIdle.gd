extends State
class_name EnemyIdle

@export var enemy : Enemy
@export var anim_sprite : AnimatedSprite2D

var player : CharacterBody2D

func enter():
	enemy.sees_player = false
	enemy.velocity = Vector2.ZERO
	anim_sprite.play("idle")
	player = get_tree().get_first_node_in_group("Player")

func update(delta):
	var distance_to_player
	if player:
		distance_to_player = (player.position - enemy.position).length()
		if distance_to_player <= 200:
			state_transition.emit(self, "Follow")

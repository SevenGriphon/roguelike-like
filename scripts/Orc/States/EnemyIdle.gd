extends State
class_name EnemyIdle

@export var enemy : CharacterBody2D
@export var speed = 50
@export var anim_sprite : AnimatedSprite2D
var wander_radius = 200
var player : CharacterBody2D
var wander_position : Vector2
var home_point : Vector2

func randomize_wander():
	var x_position = randf_range(-1, 1) * wander_radius
	var y_position = randf_range(-1, 1) * wander_radius
	wander_position = home_point + Vector2(x_position, y_position)

func enter():
	home_point = enemy.position
	randomize_wander()
	player = get_tree().get_first_node_in_group("Player")

func update(delta):
	var distance_to_wander_position = (wander_position - enemy.position).length()
	if distance_to_wander_position < 30:
		randomize_wander()

	if enemy.velocity.length():
		anim_sprite.play("run")
	else:
		anim_sprite.play("idle")

func physics_update(delta):
	if enemy:
		var distance_to_player
		if player:
			distance_to_player = (player.position - enemy.position).length()
		if !player or distance_to_player > 200:
			var wander_direction = (wander_position - enemy.position).normalized()
			enemy.velocity = wander_direction * speed
		else:
			state_transition.emit(self, "Follow")

func exit():
	enemy.velocity = Vector2.ZERO

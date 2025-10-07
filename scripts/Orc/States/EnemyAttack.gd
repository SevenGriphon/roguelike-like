extends State
class_name EnemyAttack

@export var enemy : CharacterBody2D
@export var anim_sprite : AnimatedSprite2D
@export var anim_player : AnimationPlayer
@export var hurtbox : Hurtbox
@export var speed = 200

func enter():
	if anim_sprite and enemy:
		anim_sprite.play("attack_2")
		anim_player.play("attack")

func toggle_hurtbox(state):
	for child in hurtbox.get_children():
		if child is CollisionShape2D:
			child.disabled = !state

func update(delta):
	for area in hurtbox.get_overlapping_areas():
		if area is Hitbox:
			enemy.velocity = Vector2.ZERO

func _attack_charged():
	toggle_hurtbox(true)
	var player : CharacterBody2D = get_tree().get_first_node_in_group("Player")
	if player:
		var player_direction = (player.position - enemy.position).normalized()
		enemy.velocity = player_direction * speed

func _animation_finished():
	state_transition.emit(self, "Follow")

func exit():
	enemy.velocity = Vector2.ZERO
	call_deferred("toggle_hurtbox", false)
	if anim_player.is_playing():
		anim_player.stop()

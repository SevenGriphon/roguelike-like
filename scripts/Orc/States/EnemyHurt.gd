extends State
class_name EnemyHurt

@export var enemy : CharacterBody2D
@export var anim_sprite : AnimatedSprite2D

func enter():
	if enemy.health > 0:
		anim_sprite.play("hurt")
		anim_sprite.animation_finished.connect(_on_animation_finished, ConnectFlags.CONNECT_ONE_SHOT)
	else:
		state_transition.emit(self, "Dead")

func _on_animation_finished():
	state_transition.emit(self, "AgresiveFollow")

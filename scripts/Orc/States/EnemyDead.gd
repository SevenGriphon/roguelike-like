extends State
class_name EnemyDead

@export var enemy : CharacterBody2D
@export var anim_sprite : AnimatedSprite2D

func enter():
	anim_sprite.play("death")
	anim_sprite.animation_finished.connect(_on_animation_finished, ConnectFlags.CONNECT_ONE_SHOT)

func _on_animation_finished():
	enemy.died.emit()
	enemy.queue_free()

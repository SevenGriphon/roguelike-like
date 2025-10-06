extends Area2D

@export var enemy : CharacterBody2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and body.has_method("damage"):
		var knockback_direction = (body.position - enemy.position).normalized()
		body.damage(50, knockback_direction)

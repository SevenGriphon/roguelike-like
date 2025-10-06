extends Area2D

@export var damage = 80

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("damage"):
		body.damage(damage, Vector2(1,0) * self.get_parent().scale.x)

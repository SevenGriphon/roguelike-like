extends Area2D

@export var damage : int = 50

func _on_area_entered(area: Area2D) -> void:
	if area is Hitbox:
		area.take_damage(damage)

class_name Arrow extends Node2D

@export var hurtbox :Hurtbox

var speed = 30

func _process(delta: float) -> void:
	self.position += Vector2.from_angle(self.rotation) * speed

func on_hit():
	self.queue_free()

# for this to work with walls hurtbox must be Monitorable
func _on_hurtbox_body_entered(_body: Node2D) -> void:
	on_hit()

func _on_hurtbox_area_entered(area: Area2D) -> void:
	on_hit()

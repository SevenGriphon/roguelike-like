extends Area2D

var speed = 30
var damage = 50

func _process(delta: float) -> void:
	self.position += Vector2.from_angle(self.rotation) * speed

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("damage"):
		body.damage(50, Vector2.from_angle(self.rotation))
	self.queue_free()

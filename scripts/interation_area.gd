class_name InteractionArea extends Area2D

@export var action_text = "Interact"

func  _ready() -> void:
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	InteractionManager.register_area(self)

func _on_body_exited(body: Node2D) -> void:
	InteractionManager.unregister_area(self)

var on_interact : Callable = func():
	pass

class_name EnemyPathfinding extends NavigationAgent2D

@onready var enemy: Enemy = $".."
var speed : int
var enabled : bool = false

func _physics_process(delta: float) -> void:
	if not enabled:
		return
	if !self.is_target_reached():
		var target_direction = enemy.to_local(get_next_path_position()).normalized()
		enemy.velocity = target_direction * speed
	else:
		enabled = false
		enemy.velocity = Vector2.ZERO

func set_destination(posiiton : Vector2, new_speed : int):
	self.target_position = posiiton
	speed = new_speed
	enabled = true

func disable():
	enabled = false
	enemy.velocity = Vector2.ZERO

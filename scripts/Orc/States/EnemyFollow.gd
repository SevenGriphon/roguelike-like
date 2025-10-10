extends  State
class_name EnemyFollow

@export var enemy : Enemy
@export var anim_sprite : AnimatedSprite2D
@export var speed = 100
@export var agro_label : AgroLabel

var player :CharacterBody2D
var path_timer = Timer.new()
var ignore_distance = false

func _ready() -> void:
	path_timer.wait_time = 0.5
	self.add_child(path_timer)
	path_timer.timeout.connect(_on_timer_timeout)

func enter():
	if !enemy.sees_player:
		agro_label.appear()
	enemy.sees_player = true
	player = get_tree().get_first_node_in_group("Player")
	path_timer.start(0.5)

func _on_timer_timeout():
	enemy.pathfinding.set_destination(player.global_position, speed)

func follow_player():
	if !player:
		state_transition.emit(self, "Idle")
		return
	if enemy:
		var player_direction = (player.position - enemy.position)
		if player_direction.length() < 350 or ignore_distance:
			if player_direction.length() <= 150:
				state_transition.emit(self, "Attack")
		else:
			state_transition.emit(self, "Idle")

func physics_update(delta):
	follow_player()

func update(delta):
	if enemy.velocity.length():
		anim_sprite.play("run")
	else:
		anim_sprite.play("idle")

func exit():
	enemy.pathfinding.disable()
	path_timer.stop()

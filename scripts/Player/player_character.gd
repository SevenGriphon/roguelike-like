class_name Player extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var anim_sprite = $AnimatedSprite2D
@onready var attack_pivot = $AttackPivot
@export var player_state_machine : PlayerStateMachine
var direction : Vector2

func set_animation(animation : String):
	animation_player.play(animation)

func _ready() -> void:
	player_state_machine.initiate(self)

func _process(delta: float) -> void:
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	direction = direction.normalized()
	var mouseAngle = rad_to_deg(get_local_mouse_position().angle())
	anim_sprite.flip_h = abs(mouseAngle) > 90
	attack_pivot.scale.x = -1 if abs(mouseAngle) > 90 else 1

func _physics_process(delta: float) -> void:
	move_and_slide()

#var speed = 150
#var health = 250
#var isAttacking = false
#var is_hurt = false
#var mele_damage = 80
#var knockback = 150
#
#@export var projectile_tscn :PackedScene
#
#func _process(delta: float) -> void:
	#if !isAttacking and !is_hurt:
		#if Input.is_action_just_pressed("attack"):
			#isAttacking = true
			#anim_sprite.play("attack")
			#animation_player.play("attack") # "timer" to spawn arrow at the right moment
		#elif Input.is_action_just_pressed("mele_attack"):
			#isAttacking = true
			#anim_sprite.play("mele_attack")
			#animation_player.play("mele_attack") # animation that controls mele hurtbox
		#
	#
#
#func _physics_process(delta: float) -> void:
	#var movement_direction :Vector2
	#if !isAttacking:
		#var x_direction :int = Input.get_axis("move_left", "move_right")
		#var y_direction :int = Input.get_axis("move_up", "move_down")
		#movement_direction = Vector2(x_direction, y_direction).normalized()
	#else:
		#movement_direction = Vector2.ZERO
	#
	#if !(isAttacking or is_hurt):
		#if movement_direction != Vector2.ZERO:
			#anim_sprite.play("run")
		#else:
			#anim_sprite.play("idle")
	#
	#if !is_hurt:
		#self.velocity = movement_direction * speed
	#
	#self.move_and_slide()
#
#func _on_animated_sprite_2d_animation_finished() -> void:
	#if anim_sprite.animation == "attack" or anim_sprite.animation == "mele_attack":
		#isAttacking = false
	#elif  anim_sprite.animation == "hurt":
		#is_hurt = false
#
#func _spawn_arrow():
	#var mouse_angle = get_local_mouse_position().angle()
	#var arrow :Area2D = projectile_tscn.instantiate()
	#arrow.rotation = mouse_angle
	#arrow.position = self.position + attack_pivot.position
	#get_tree().current_scene.add_child(arrow)
#
#
#func _on_mele_attack_hurtbox_body_entered(body: Node2D) -> void:
	#if body.has_method("damage"):
		#body.damage(mele_damage, Vector2(1,0) * attack_pivot.scale.x)
#
#func damage(amount, knockback_direction : Vector2):
	#health -= amount
	#isAttacking = false
	#is_hurt = true
	#if health <= 0:
		#anim_sprite.play("death")
		#animation_player.play("death")
	#else:
		#self.velocity = knockback_direction.normalized() * knockback
		##print(self.velocity)
		#anim_sprite.play("hurt")
#
#func death():
	#self.queue_free()

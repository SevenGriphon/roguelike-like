extends CharacterBody2D

@onready var anim_sprite :AnimatedSprite2D = $AnimatedSprite2D
@export var hitbox : Hitbox

var health = 100
var knockback = 100
signal damaged
signal died

func _ready() -> void:
	hitbox.damaged.connect(func(damage):
		health -= damage
		damaged.emit()
		#if health > 0:
			#self.velocity = knockback_direction.normalized() * knockback
	)

func _process(delta: float) -> void:
	if self.velocity.x < 0:
		anim_sprite.flip_h = true
	elif self.velocity.x > 0:
		anim_sprite.flip_h = false

func _physics_process(delta: float) -> void:
	move_and_slide()

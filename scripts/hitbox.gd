class_name Hitbox extends Area2D

signal damaged(damage)

func take_damage(damage):
	print(damage)
	damaged.emit(damage)

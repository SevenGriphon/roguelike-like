class_name Weapon extends Node

func enter(_player):
	pass

func exit():
	pass

func update(delta) -> bool:
	return false

func physics_update(delta) -> PlayerState:
	return null

func handle_input(event : InputEvent) -> PlayerState:
	return null

class_name PlayerState extends Node

static var player : Player
static var state_machine : PlayerStateMachine

func enter():
	pass

func exit():
	pass

func update(delta) -> PlayerState:
	return null

func physics_update(delta) -> PlayerState:
	return null

func handle_input(event : InputEvent) -> PlayerState:
	return null

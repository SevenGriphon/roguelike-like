class_name Weapon extends Node

var player :Player
var animation_event : Signal

func enter(_player : Player, _animation_event : Signal):
	player = _player
	animation_event = _animation_event
	animation_event.connect(_on_animation_event)

func exit():
	animation_event.disconnect(_on_animation_event)

func update(delta) -> bool:
	return false

func physics_update(delta) -> PlayerState:
	return null

func handle_input(event : InputEvent) -> PlayerState:
	return null

func _on_animation_event(event_name : String):
	call(event_name)

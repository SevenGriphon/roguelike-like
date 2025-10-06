extends Node

@export var initial_state :State
@export var enemy : CharacterBody2D

var current_state :State
var states :Dictionary = {}

func _ready() -> void:
	for state in self.get_children():
		if state is State:
			states[state.name] = state
			state.state_transition.connect(_on_state_transition)
	if initial_state:
		current_state = initial_state
		initial_state.enter()
	
	enemy.damaged.connect(func():
		change_state("Hurt")
	)


func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)


func  _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func change_state(new_state_name :String):
	var new_state = states[new_state_name]
	if current_state != new_state:
		current_state.exit()
		current_state = new_state
		new_state.enter()

func  _on_state_transition(from_state :State, new_state_name :String):
	if from_state != current_state:
		return
	if new_state_name in states:
		change_state(new_state_name)
	else:
		print("State "+new_state_name+" not found")

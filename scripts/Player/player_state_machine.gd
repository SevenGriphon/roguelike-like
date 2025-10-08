class_name PlayerStateMachine extends Node

var states : Array[PlayerState] = []
var current_state : PlayerState
@export var initial_state : PlayerState

func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_DISABLED

func initiate(player : Player):
	self.process_mode = Node.PROCESS_MODE_INHERIT
	
	for child in self.get_children():
		if child is PlayerState:
			states.append(child)
	
	for state in states:
		state.state_machine = self
	
	if states.size() > 0:
		if !initial_state:
			initial_state = states[0]
		initial_state.player = player
		change_state(initial_state)

func _process(delta: float) -> void:
	if current_state:
		change_state(current_state.update(delta))

func _physics_process(delta: float) -> void:
	if current_state:
		change_state(current_state.physics_update(delta))

func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		change_state(current_state.handle_input(event))

func change_state(new_state : PlayerState):
	if new_state == null or new_state == current_state:
		return
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter()

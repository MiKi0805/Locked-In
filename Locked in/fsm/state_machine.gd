class_name StateMachine
extends Node


var current_state : State
var states : Dictionary = {}

@export var initial_state : State


func _ready():
	# Get the stored states 
	for child in get_children():
		if child is State:
			# Apply state to dictionary
			states[child.name.to_lower()] = child
			# Connect signal from state
			child.change_state.connect(on_child_transition)
	
	# Start with the initial state
	if initial_state:
		initial_state.state_enter()
		current_state = initial_state


# Updating current running state
func _process(delta):
	if current_state:
		current_state.state_process(delta)


# Updating physics from current running state
func _physics_process(delta):
	if current_state:
		current_state.state_physics_process(delta)


# Change to different state
func on_child_transition(state, new_state_name):
	# Setup to change state
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_snake_case())
	
	if !new_state:
		return
	
	# Exit from current state
	if current_state:
		current_state.state_exit()
	
	# Enter the new state
	new_state.state_enter()
	
	current_state = new_state

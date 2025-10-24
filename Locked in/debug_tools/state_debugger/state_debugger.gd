@tool
extends Node2D


## State machine to track.
@export var state_machine: StateMachine
## A string variable written before the current state from tracked state machine.
@export var pre_state_info: String = "Current state: "

@export var offset: Vector2

var label_default_position: Vector2

@onready var label: Label = $Label


func _ready() -> void:
	label_default_position = label.position


func _process(_delta: float) -> void:
	_ignore_rotation()
	
	label_default_position.x = -label.size.x / 2
	label.position = label_default_position + offset
	
	# Check if state_machine is valid before accessing current_state
	var final_output: String = pre_state_info
	if not Engine.is_editor_hint():
		if state_machine != null and state_machine.current_state != null:
			final_output = pre_state_info + str(state_machine.current_state.name)
		else:
			final_output = pre_state_info
	
	label.text = final_output


func _ignore_rotation():
	rotation = -get_parent().rotation

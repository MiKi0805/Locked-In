class_name State
extends Node


@warning_ignore("unused_signal")
signal change_state(transition_to:State)


func state_enter():
	pass


func state_process(_delta: float):
	pass


func state_physics_process(_delta: float):
	pass


func state_exit():
	pass

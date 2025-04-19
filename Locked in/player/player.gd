class_name Player
extends CharacterBody2D


@export var speed: float = 500
## To ease current velocity to wanted velocity,
## less value more smoothing & vice versa
@export var smoothing: float = 10


func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())


func _physics_process(_delta: float) -> void:
	move_and_slide()

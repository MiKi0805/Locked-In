class_name Player
extends CharacterBody2D


@export var speed: float = 500
## To ease current velocity to wanted velocity,
## less value more smoothing & vice versa
@export var acceleration: float = 2
@export var deceleration: float = 10


func _process(_delta: float) -> void:
	var target_pos = get_global_mouse_position()
	var direction = (target_pos - global_position).angle()
	rotation = lerp_angle(rotation, direction, 10 * _delta)


func _physics_process(_delta: float) -> void:
	move_and_slide()

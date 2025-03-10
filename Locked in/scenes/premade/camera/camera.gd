#@icon
class_name CustomCamera2D
extends Camera2D


@export var follow_target : Node2D
@export var speed : float = 5
@export_group("Weight to Mouse")
@export var weight_to_mouse : bool = false
@export_range(1, 5) var follow_weight : float = 5


func _process(delta):
	follow(delta)


func follow(delta):
	if follow:
		var target_position: Vector2 = follow_target.global_position
		if weight_to_mouse:
			var mouse_position = get_global_mouse_position()
			# Calculate the point between the target and mouse position
			target_position = lerp(
					follow_target.global_position, 
					mouse_position, 
					follow_weight * delta
					)
		global_position = lerp(global_position, target_position, speed * delta)

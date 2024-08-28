extends Camera2D

@export var _follow : Node2D
@export var speed : float = 5
@export var weight_to_mouse : bool = false
@export_range(5, 10) var follow_weight : float = 1.0
@export var screen_shake_intensity : int = 5
var shake_count : int

@onready var search_node = $"../Enemy container"
var enemies_count_before : int


func _process(delta):
	follow(delta)


func follow(delta):
	if follow:
		var target_position = _follow.global_position
		if weight_to_mouse:
			var mouse_position = get_global_mouse_position()
			# Calculate the point between the target and mouse position
			target_position = _follow.global_position.lerp(mouse_position, 1.0 / follow_weight)
		global_position = lerp(global_position, target_position, speed * delta)

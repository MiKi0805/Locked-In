#@icon
class_name CustomCamera2D
extends Camera2D


@export var follow_target : Node2D
@export var speed : float = 5
@export_group("Weight to Mouse")
@export var weight_to_mouse : bool = false
@export_range(1, 5) var follow_weight : float = 5

@export_group("Screen Shake")
@export var shake_ease_out: float = 5.0
var shake_strength: float


func _ready() -> void:
	SignalBus.shake_screen.connect(_apply_shake)


func _process(delta):
	_follow(delta)
	_shake_screen(delta)


func _follow(delta):
	if follow_target:
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


#region Screen Shake
func _apply_shake(strength):
	shake_strength = strength


func _shake_screen(delta: float):
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0.0, shake_ease_out * delta)
		var x = randf_range(-shake_strength, shake_strength)
		var y = randf_range(-shake_strength, shake_strength)
		offset = Vector2(x, y)
#endregion

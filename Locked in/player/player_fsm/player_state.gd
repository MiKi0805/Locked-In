class_name PlayerState
extends State


@export var player: Player

var input: Vector2


func _process(delta: float) -> void:
	var input_y = Input.get_axis("up", "down")
	var input_x = Input.get_axis("left", "right")
	input = Vector2(input_x, input_y).normalized()

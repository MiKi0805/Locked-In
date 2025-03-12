extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#velocity = global_position.direction_to(get_tree().get_first_node_in_group("player").global_position) * 5 * delta
	
	move_and_slide()

extends Node2D

# signal for direction value
signal  direction_read(direction : Vector2)

# bullet enter listen
func bullet_enter(body):
	var dir = global_position - body.global_position
	dir = dir.normalized()
	emit_signal("direction_read", dir)

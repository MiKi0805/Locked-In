extends Path2D


@export var markers: Array[Node2D]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in curve.point_count:
		if i <= markers.size() - 1 and markers[i] != null:
			var marker_relative_pos = (
					markers[i].position
					+ markers[i].get_parent().position
			)
			print(marker_relative_pos)
			curve.set_point_position(i, marker_relative_pos)
		else:
			continue

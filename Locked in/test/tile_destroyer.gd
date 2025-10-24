extends NinePatchRect


@export var tilemap : TileMapLayer
@export var grid_size := 16


func _ready():
	# Call this whenever you want to clear tiles inside the area
	remove_tiles_in_area()

func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	var snapped_pos = Vector2(
		floor(mouse_pos.x / grid_size) * grid_size,
		floor(mouse_pos.y / grid_size) * grid_size
	)
	global_position = snapped_pos

	remove_tiles_in_area()

func remove_tiles_in_area():
	var shape_rect = get_global_rect()

	# Convert it to the tilemap's local coordinate space
	var tile_rect = Rect2(
		tilemap.to_local(shape_rect.position),
		shape_rect.size
	)

	# Convert that to tile coords
	var start = tilemap.local_to_map(tile_rect.position)
	var end = tilemap.local_to_map(tile_rect.position + tile_rect.size)

	for x in range(start.x, end.x):
		for y in range(start.y, end.y):
			tilemap.erase_cell(Vector2i(x, y))

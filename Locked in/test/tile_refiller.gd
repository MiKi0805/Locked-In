extends NinePatchRect

@export var tilemap : TileMapLayer
@export var grid_size := 16

func _ready():
	fill_tiles_in_area()

func _process(delta: float) -> void:
	fill_tiles_in_area()

func fill_tiles_in_area():
	var shape_rect = get_global_rect()

	var tile_rect = Rect2(
		tilemap.to_local(shape_rect.position),
		shape_rect.size
	)

	var start = tilemap.local_to_map(tile_rect.position)
	var end = tilemap.local_to_map(tile_rect.position + tile_rect.size)

	for x in range(start.x, end.x):
		for y in range(start.y, end.y):
			var tile_pos = Vector2i(x, y)
			tilemap.set_cell(tile_pos, 0, Vector2i(1, 1))

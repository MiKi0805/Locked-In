extends TileMapLayer


const destroy_particle_scene: PackedScene = preload("res://test/destroy_tile_particle.tscn")
const build_particle_scene: PackedScene = preload("res://test/build_tile_particle.tscn")

const sfx: AudioStream = preload("res://audios/preset_sfx/heavy_shot_sfx.tres")

var previous_tiles := {}

func _ready():
	# Cache all tiles at start
	previous_tiles = get_all_tiles()


func _process(delta: float) -> void:
	if Input.is_action_pressed("secondary_action"):
		var tile = local_to_map(get_global_mouse_position())
		set_cell(tile, 0, Vector2i(1, 1))
	
	if Input.is_action_pressed("esc"):
		var tile = local_to_map(get_global_mouse_position())
		erase_cell(tile)
	
	_on_tilemap_changed()


func _on_tilemap_changed():
	var current_tiles = get_all_tiles()
	
	# Check for removed tiles
	for pos in previous_tiles.keys():
		if not current_tiles.has(pos):
			spawn_particle(map_to_local(pos), destroy_particle_scene)
			
			SignalBus.shake_screen.emit(2)
			SfxHandler.play_sfx(sfx, get_global_mouse_position())
	
	# Check for added tiles
	for pos in current_tiles.keys():
		if not previous_tiles.has(pos):
			spawn_particle(map_to_local(pos), build_particle_scene)
			
			SignalBus.shake_screen.emit(2)
			SfxHandler.play_sfx(sfx, get_global_mouse_position())
	
	# Update stored tile data
	previous_tiles = current_tiles

func get_all_tiles() -> Dictionary:
	var tile_data := {}
	var used_cells = get_used_cells()  # Only checking layer 0 for simplicity
	for pos in used_cells:
		tile_data[pos] = get_cell_source_id(pos)
	return tile_data

func spawn_particle(local_pos: Vector2, particle_scene: PackedScene):
	if particle_scene:
		var particle: GPUParticles2D = particle_scene.instantiate()
		particle.global_position = to_global(local_pos)
		add_child(particle)
		particle.emitting = true

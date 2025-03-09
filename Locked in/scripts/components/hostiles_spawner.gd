extends Node2D

# hostiles entities spawn location limiter
@onready var limit = %limiter
# between spawn timer
@onready var delay = %"Spawn delay"

# min to max delay
@export var min_delay : float = 5
@export var max_delay : float = 10

# number limit
@export var limit_spawn : bool
@export var max_spawn : int
var current_spawn : int

# hostile entities properties
var enemy_location : String = "res://Scenes/Characters/challenger.tscn"
# enemy intance (apply when first spawn)
var enemy_scene
# node to store every spawned enemy (apply when first spawn)
var enemy_container : Node2D

# apply when first spawn
var first_spawn : bool = true

# xp zone scene
var xp_zone_scene : PackedScene = load("res://Scenes/Objects/xp_zone.tscn")
# xp zone container
@onready var xp_zone_container = $"../XP Zone Container"


func _ready():
	var set_delay_time = randf_range(min_delay, max_delay)
	delay.start(set_delay_time)
	$"../Dev panel".spawn_enemy_request.connect(add_max)

func add_max():
	Helper.add(max_spawn, 1)
	spawn_hostile_entities(true)


func _process(delta):
	if xp_zone_container.get_child_count() == 0:
		spawn_xp_zone()


func randomize_spawn_pos() -> Vector2:
	var x = randf_range(
		limit.get_child(0).global_position.x,
		limit.get_child(1).global_position.x
	)
	var y = randf_range(
		limit.get_child(2).global_position.y,
		limit.get_child(3).global_position.y
	)
	return Vector2(x, y)


func spawn_hostile_entities(once : bool = false):
	if first_spawn:
		enemy_scene = load(enemy_location)
		# disable 'use once' variables
		enemy_location = ''
		first_spawn = false
		enemy_container = get_tree().get_first_node_in_group("enemy_container")
	
	# spawn enemy
	var enemy_spawn = enemy_scene.instantiate()
	
	# set enemy position
	enemy_spawn.position = randomize_spawn_pos()
	enemy_container.add_child(enemy_spawn)
	
	current_spawn += 1
	
	if !once:
		start_delay()
	return


func spawn_xp_zone():
	# create instantiate
	var xp_zone_instantiate = xp_zone_scene.instantiate()
	
	# set position
	xp_zone_instantiate.position = randomize_spawn_pos()
	xp_zone_container.add_child(xp_zone_instantiate)


func start_delay():
	var set_delay_time = randf_range(min_delay, max_delay)
	delay.start(set_delay_time)


func delay_timeout():
	delay.stop()
	if limit_spawn && current_spawn >= max_spawn:
		return
	spawn_hostile_entities()

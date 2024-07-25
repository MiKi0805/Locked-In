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


func _ready():
	var set_delay_time = randf_range(min_delay, max_delay)
	delay.start(set_delay_time)


func spawn_hostile_entities():
	if first_spawn:
		enemy_scene = load(enemy_location)
		# disable 'use once' variables
		enemy_location = ''
		first_spawn = false
		enemy_container = get_tree().get_first_node_in_group("enemy_container")
	
	# spawn enemy
	var enemy_spawn = enemy_scene.instantiate()
	
	# set enemy position
	enemy_spawn.position.x = randf_range(
		limit.get_child(0).global_position.x,
		limit.get_child(1).global_position.x
	)
	enemy_spawn.position.y = randf_range(
		limit.get_child(2).global_position.y,
		limit.get_child(3).global_position.y
	)
	enemy_container.add_child(enemy_spawn)
	
	current_spawn += 1
	
	start_delay()


func start_delay():
	var set_delay_time = randf_range(min_delay, max_delay)
	delay.start(set_delay_time)


func delay_timeout():
	delay.stop()
	if limit_spawn && current_spawn == max_spawn:
		return
	spawn_hostile_entities()

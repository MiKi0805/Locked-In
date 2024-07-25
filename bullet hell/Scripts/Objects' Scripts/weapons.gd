extends Node2D


#Shooting variables
# bullet spawn per sec
var fire_rate : int = 5
# cooldown fire rate
var shot_cooldown : float = 0
# bullet scene file location
var bullet_scene : String = "res://Scenes/Objects/bullet.tscn"
# bullet parent (place bullet here)
var bullet_container : Node2D
var bullet_container_location : String = "res://Scenes/Objects/bullet_container.tscn"
# marker (spawn bullet here)
@onready var bullet_initial_pos : Marker2D = %"Bullet spawn"
# first shot (load bullet only when the first shot)
var first_shot : bool = true
# random inaccuracy angle (randomize shot direction between the value) (recommend use value under 0.3)
var inaccuracy_angle : float = 0.15

#Bullet properties
# speed
var initial_bullet_speed : float = 400.0
# bullet life time / range
var life_time : float = 3

#Bullet scene load
# applied when first shot
var bullet_intance


#Particle
@onready var particle_control = %particle

#SFX
var shoot_sfx : PackedScene = load("res://Scenes/Objects/SFXs/shoot_sfx.tscn")


func _ready():
	# set bullet_container node
	bullet_container = get_tree().get_first_node_in_group("bullet_container")

func _process(_delta):
	input_listen()


# listen shoot input button
func input_listen():
	if Input.is_action_pressed("shoot") && !cooldown():
		spawn_bullet()


#cooldown flag
func cooldown():
	if shot_cooldown > 0:
		cooldown_decrease_time()
		return true
	elif shot_cooldown <= 0:
		return false

# decrease cooldown time
func cooldown_decrease_time():
	shot_cooldown -= 1 * get_process_delta_time()


# spawn bullet in scene
func spawn_bullet():
	if first_shot:
		bullet_intance = load(bullet_scene)
		# disable 'use once' variables
		bullet_scene = ""
		first_shot = false
	
	# spawn bullet
	var bullet_spawn = bullet_intance.instantiate()
	
	# set bullet position
	bullet_spawn.position = bullet_initial_pos.global_position
	# set bullet rotation
	bullet_spawn.rotation = global_position.direction_to(get_global_mouse_position()).angle()
	# set inaccuracy
	var spread = randf_range(-inaccuracy_angle, inaccuracy_angle)
	# bullet setup
	bullet_spawn.setup(initial_bullet_speed, life_time, spread)
	
	# add bullet as a child
	bullet_container.add_child(bullet_spawn)
	# set cooldown
	shot_cooldown = 1.0 / float(fire_rate)
	
	# spawn particle
	particle_control.shoot_particle()
	
	#spawn sfx
	var sfx = shoot_sfx.instantiate()
	add_child(sfx)

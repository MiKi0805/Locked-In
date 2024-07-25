extends Node2D

# shoot particle
var shoot_particle_scene = preload("res://Scenes/Objects/shoot_particle.tscn")

# trail
@onready var trail_particle := $"Player particle"


func shoot_particle():
	var spawn = shoot_particle_scene.instantiate()
	spawn.rotation = rotation_degrees
	spawn.position = $"bullet particle".position
	%particle.add_child(spawn)
	spawn.emitting = true

func _process(delta):
	if $"..".velocity != Vector2.ZERO:
		trail_particle.emitting = true
	else:
		trail_particle.emitting = false

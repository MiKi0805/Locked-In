extends Node2D
class_name Health_system

# changeable hp
@export var health_points : int = 5

# hostile bool
@export var is_enemy : bool = false
var enemy_hit_particle = preload("res://Scenes/Objects/enemy_hit_particle.tscn")
# special enemy
var dir : Vector2

# dead signal
signal hp_zero


func reset_hp(hp_request : int):
	health_points = hp_request


# body enter
func hit(body):
	body.queue_free()
	health_points -= 1
	if is_enemy:
		var particle = enemy_hit_particle.instantiate()
		get_tree().root.add_child(particle)
		particle.setup(dir)
		particle.position = global_position
	if health_points == 0:
		hp_zero.emit()


func bullet_approach_direction(direction):
	dir = direction

extends Node2D
class_name Health_component

@export var max_health : int
@onready var health : int = max_health

var hit_count : int = 0

signal die(hit_count : int)

func damage(damage):
	health -= damage
	
	if health <= 0:
		emit_signal("die", hit_count)

func reset_hp(target_hp : int):
	health = target_hp
	if health > max_health:
		max_health = health

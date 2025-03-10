@icon("uid://d1h8nl5aet7gy")
class_name Health
extends Node


## Give the a health point to the parent.
## Health can be decreased by 'Hit' component.


@export var max_health: int
@onready var health: int :
	set(value):
		value = max_health
		health = value

var hit_count: int = 0

signal die(hit_count: int)


func deal_damage(damage):
	health -= damage
	
	if health <= 0:
		emit_signal("die", hit_count)


func reset_hp(target_hp : int):
	health = target_hp
	if health > max_health:
		max_health = health

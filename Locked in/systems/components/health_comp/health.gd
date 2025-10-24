@icon("uid://d1h8nl5aet7gy")
class_name Health
extends Node


## Give the a health point to the parent.
## Health can be decreased by Hitbox component.


@export var max_health: int

@export var debug_kill: bool = false

var health: int

var hit_count: int = 0

signal die(hit_count: int)


func _ready() -> void:
	health = max_health

	if debug_kill:
		die.connect(func(): get_parent().queue_free())


func deal_damage(damage):
	health -= damage

	if Global.debug_mode:
		print(self, " | Damage: %d" % damage, " | Health left: %d" % health)

	if health <= 0:
		emit_signal("die")


func reset_hp(target_hp : int):
	health = target_hp
	if health > max_health:
		max_health = health

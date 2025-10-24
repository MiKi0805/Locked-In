@abstract class_name FireMode
extends Node


signal on_shot(fire_mode_stats: FireModeStats)

@export var stats: FireModeStats

var weapon_stats: WeaponStats
var weapon: Weapon


func _emit_on_shot():
	on_shot.emit(stats)


func triggered():
	pass


func set_bullet_data(damage: int = -1, speed: float = -1):
	weapon_stats.bullet_data.damage = damage
	weapon_stats.bullet_data.speed = speed

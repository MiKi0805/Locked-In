class_name FireMode
extends Node


@export var knockback: float = 10
@export var shot_sfx: AudioStream

var weapon_stats: WeaponStats
var weapon: Weapon


func triggered():
	pass


func set_bullet_data(damage: int = -1, speed: float = -1):
	weapon_stats.bullet_data.damage = damage
	weapon_stats.bullet_data.speed = speed

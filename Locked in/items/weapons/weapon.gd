class_name Weapon
extends Node2D


signal weapon_shot(knockback: float)

@export var weapon_stats: WeaponStats
@export var muzzle: Marker2D
@export var fire_mode: FireMode


func _ready() -> void:
	if fire_mode == null:
		printerr("'fire_mode' is null")
		breakpoint
	
	fire_mode.weapon_stats = weapon_stats
	fire_mode.weapon = self


func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		fire_mode.triggered()


func shoot():
	SfxHandler.play_sfx(fire_mode.shot_sfx, muzzle.global_position)
	
	weapon_stats.bullet_data.starting_position = muzzle.global_position
	
	var base_direction = muzzle.global_transform.x.normalized()
	var spread = deg_to_rad(randf_range(-weapon_stats.spread, weapon_stats.spread))
	weapon_stats.bullet_data.direction = base_direction.rotated(spread)
	
	print("shot")
	
	weapon_shot.emit()
	
	BulletSpawner.spawn_bullet(weapon_stats.bullet_data)

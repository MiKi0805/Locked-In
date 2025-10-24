class_name Weapon
extends Node2D


enum SHOOT_INPUT { LEFT_CLICK, RIGHT_CLICK }

@export var weapon_stats: WeaponStats
@export var muzzle: Marker2D
@export var fire_mode: FireMode
@export var shoot_mode: SHOOT_INPUT


func _ready() -> void:
	if fire_mode == null:
		printerr("'fire_mode' is null")
		breakpoint
	
	fire_mode.weapon_stats = weapon_stats
	fire_mode.weapon = self


func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	if (shoot_mode == SHOOT_INPUT.LEFT_CLICK and Input.is_action_pressed("primary_action")) \
		or (shoot_mode == SHOOT_INPUT.RIGHT_CLICK and Input.is_action_pressed("secondary_action")):
		fire_mode.triggered()
	
	position.x = clamp(position.x, -3, 0)
	position.x = lerp(position.x, 0.0, 5 * delta)


func shoot():
	position.x = -3
	
	SfxHandler.play_sfx(fire_mode.stats.shot_sfx, muzzle.global_position)
	SignalBus.shake_screen.emit(fire_mode.stats.screen_shake_strength)
	
	weapon_stats.recoil_knockback = fire_mode.stats.knockback
	
	weapon_stats.bullet_data.starting_position = muzzle.global_position
	
	var base_direction = muzzle.global_transform.x.normalized()
	var spread = deg_to_rad(randf_range(-weapon_stats.spread, weapon_stats.spread))
	weapon_stats.bullet_data.direction = base_direction.rotated(spread)
	
	BulletSpawner.spawn_bullet(weapon_stats.bullet_data)

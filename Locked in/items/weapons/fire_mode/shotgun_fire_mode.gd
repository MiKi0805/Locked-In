class_name ShotgunFireMode
extends FireMode


## How many bullet will be spawn per shot.
@export var bullet_count: int = 6
## Firerate for shot/sec.
@export var fire_rate: float = 1
@export var cooldown: Cooldown


func triggered():
	if cooldown.is_ready():
		weapon.weapon_stats.recoil_knockback = knockback
		for i in bullet_count:
			weapon.shoot()
		cooldown.trigger(1 / fire_rate)

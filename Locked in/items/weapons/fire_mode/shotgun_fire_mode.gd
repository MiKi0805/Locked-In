class_name ShotgunFireMode
extends FireMode


## How many bullet will be spawn per shot.
@export var bullet_count: int = 6
## Firerate for shot/sec.
@export var fire_rate: float = 1
@export var cooldown: Cooldown


func triggered():
	if cooldown.is_ready():
		for i in bullet_count:
			weapon.shoot()
		_emit_on_shot()
		cooldown.trigger(1 / fire_rate)

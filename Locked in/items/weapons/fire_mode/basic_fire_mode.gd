class_name BasicFireMode
extends FireMode


## Firerate for shot/sec.
@export var fire_rate: float = 2
@export var cooldown: Cooldown


func triggered():
	if cooldown.is_ready():
		weapon.shoot()
		_emit_on_shot()
		cooldown.trigger(1 / fire_rate)

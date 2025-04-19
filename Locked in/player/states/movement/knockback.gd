extends PlayerState


@export var weapon: Weapon
@export var knockback_duration: float = 0.2

var knockback_spend: float = 0.0


func state_enter():
	knockback_spend = 0.0


func state_physics_process(delta: float):
	player.velocity = lerp(
			player.velocity, 
			input * player.speed / 2, # Use half of the speed when having knockback
			delta * player.smoothing
	)
	
	if knockback_spend < knockback_duration:
		knockback_spend += delta
		player.velocity += -player.global_transform.x * weapon.weapon_stats.recoil_knockback
	else:
		change_state.emit(self, "idle")

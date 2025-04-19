class_name Idle
extends PlayerState


func state_physics_process(delta: float):
	if input != Vector2.ZERO:
		change_state.emit(self, "normalwalk")
	else:
		player.velocity = lerp(
			player.velocity, 
			Vector2.ZERO, 
			delta * player.smoothing
		)

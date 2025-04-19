class_name NormalWalk
extends PlayerState


func state_physics_process(delta):
	player.velocity = lerp(
			player.velocity, 
			input * player.speed, 
			delta * player.smoothing
	)
	
	if input == Vector2.ZERO:
		change_state.emit(self, "idle")

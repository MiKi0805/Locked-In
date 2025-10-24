class_name NormalWalk
extends PlayerState


func state_physics_process(delta):
	player.velocity = lerp(
			player.velocity, 
			input * player.speed, 
			delta * player.acceleration
	)
	
	if input == Vector2.ZERO:
		change_state.emit("idle")

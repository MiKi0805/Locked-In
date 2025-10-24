extends PlayerState


## The object that can emit a knockback e.g. weapons
@export var effectors: Array[FireMode]

@export var knockback_duration: float = 0.2
var knockback_strength: float
var knockback_spend: float = 0.0

var knockback_queue: Array[float]


func _ready() -> void:
	# Filter: return if effectors array is empty
	if effectors.is_empty():
		return
	
	for effector in effectors:
		if effector: # If effector is not null
			effector.on_shot.connect(_set_knockback_strength)


func _set_knockback_strength(fire_mode_stats: FireModeStats):
	change_state.emit("knockback")
	knockback_queue.append(fire_mode_stats.knockback)


func state_physics_process(delta: float):
	if knockback_queue.is_empty():
		change_state.emit("idle")
		return
	
	player.velocity = lerp(
			player.velocity, 
			input * player.speed / 2, # Use half of the speed when having knockback
			delta * player.acceleration
	)
	
	for knockback in knockback_queue:
		player.velocity += -player.global_transform.x * knockback
		knockback_queue.erase(knockback)
		knockback_spend = 0
	
	knockback_spend += delta
	
	if knockback_spend >= knockback_duration:
		change_state.emit("idle")

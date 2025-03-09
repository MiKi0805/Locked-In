extends HSlider

@onready var particle := $CPUParticles2D
@onready var particle_range_min : float = $"CPUParticles2D/-x".global_position.x
@onready var particle_range_max : float = $"CPUParticles2D/+x".global_position.x

var value_before : float
var value_after : float


func _ready():
	value = 0

func _process(delta):
	value_after = value
	if value_before != value_after:
		move_particle()
		await get_tree().create_timer(0.1).timeout
		value_before = value_after
	else:
		particle.emitting = false
	
	value = lerpf(value, Global.xp, ((Global.xp - value) + 2) * delta)

func move_particle():
	particle.emitting = true
	particle.global_position.x = map_value(value, min_value, max_value, particle_range_min, particle_range_max)

func map_value(_value: float, old_min: float, old_max: float, new_min: float, new_max: float) -> float:
	return new_min + (_value - old_min) / (old_max - old_min) * (new_max - new_min)

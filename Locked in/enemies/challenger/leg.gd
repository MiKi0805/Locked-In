extends Line2D


@export var body: PhysicsBody2D
@export var step_target: Marker2D
@export var step_target_position: float
@export var step_max_length: float

var is_tweening: bool = false

@onready var target: Marker2D = $Target
@onready var ray_cast: RayCast2D = $RayCast
@onready var sfx: AudioStreamPlayer2D = $AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_randomize_leg_step_values()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	self.set_point_position(1, to_local(target.global_position))
	
	var distance_to_step_target = target.global_position.distance_to(step_target.global_position)
	if distance_to_step_target >= step_max_length and not is_tweening:
		if ray_cast.is_colliding():
			step_target.global_position = ray_cast.get_collision_point()
		else:
			_randomize_leg_step_values()
		_move_leg()


#func _draw() -> void:
	#draw_circle(to_local(step_target.global_position), 1, Color.GREEN, false, 2, true)


func _randomize_leg_step_values():
	var _step_target_position = step_target_position
	
	_step_target_position = step_target_position + randf_range(-25, 0)
	step_max_length = step_target_position / 2 + randf_range(-10, 10)
	
	ray_cast.target_position.x = step_target_position
	
	step_target.global_position = self.global_position
	var global_move = step_target.transform.basis_xform(Vector2(_step_target_position, 0))
	step_target.transform.origin += global_move


func _move_leg():
	is_tweening = true
	var tween = get_tree().create_tween()
	#tween.set_parallel(false)
	#tween.tween_property(target, "global_position", self.global_position, 0.1)
	tween.tween_property(target, "global_position", step_target.global_position + body.velocity / 2, randf_range(0.05, 0.2))
	await tween.finished
	is_tweening = false
	sfx.pitch_scale = randf_range(0.9, 1.1)
	sfx.play()

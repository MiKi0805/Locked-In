extends CharacterBody2D
class_name Player


const SPEED: float = 350.0
const ROTATE_SPEED: float = 3
const SHOOTING_SPEED: float = 100.0
const SMOOTHING: float = 5

@onready var hand_r_target: Marker2D = $Head/IKTargets/HandRTarget
@onready var hand_l_target: Marker2D = $Head/IKTargets/HandLTarget



func _process(delta):
	_rotate_to_mouse(delta)


func  _physics_process(delta):
	# call movement
	_move(delta)
	
	# run movement
	move_and_slide()


func _move(delta):
	# get input direction
	var dir : Vector2 = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	# normalize input direction
	dir = dir.normalized()
	
	# apply velocity and smoothing
	if dir != Vector2.ZERO:
		if Input.is_action_pressed("shoot"):
			velocity = lerp(velocity, Vector2(dir.x * SHOOTING_SPEED, dir.y * SHOOTING_SPEED), SMOOTHING * delta)
		else:
			velocity = lerp(velocity, Vector2(dir.x * SPEED, dir.y * SPEED), SMOOTHING * delta)
	else:
		velocity = lerp(velocity, Vector2.ZERO, SMOOTHING * delta)


func _rotate_to_mouse(delta):
	# Get direction to mouse
	var mouse_dir = (get_global_mouse_position() - global_position).normalized()
	
	# Get the angle to the mouse
	var deg_to_mouse = atan2(mouse_dir.y, mouse_dir.x)  # atan2 gives the angle in radians
	
	# Smoothly rotate towards the target angle
	rotation = lerp_angle(rotation, deg_to_mouse, ROTATE_SPEED * delta)


func _hp_zero():
	queue_free()

extends CharacterBody2D
class_name Player


#Movement
# normal speed
const SPEED: float = 350.0
const ROTATE_SPEED: float = 5
# speed while shooting
const SHOOTING_SPEED: float = 100.0
# less value = less smoothing
const SMOOTHING: float = 5



# main movement
func move(delta):
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


# rotate to mouse position
func rotate_to_mouse():
	var mouse_dir = global_position.direction_to(get_global_mouse_position())
	mouse_dir = mouse_dir.normalized()
	
	var deg_to_mouse = atan2(mouse_dir.y, mouse_dir.x)
	
	rotation = lerp_angle(rotation, deg_to_mouse, ROTATE_SPEED * get_process_delta_time())
	
	pass


func _process(_delta):
	var mouse_dir = global_position.direction_to(get_global_mouse_position())
	mouse_dir = mouse_dir.normalized()
	rotate_to_mouse()


func  _physics_process(delta):
	# call movement
	move(delta)
	
	# run movement
	move_and_slide()


func hp_zero():
	queue_free()

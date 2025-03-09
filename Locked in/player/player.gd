extends CharacterBody2D
class_name Player


#Movement
# normal speed
const SPEED := 350.0
# speed while shooting
const SHOOTING_SPEED := 100.0
# less value = less smoothing
const SMOOTHING := 5

@onready var animation_tree: AnimationTree = $AnimationTree



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
	#rotation = global_position.direction_to(get_global_mouse_position()).angle()
	pass


func _process(_delta):
	var mouse_dir = global_position.direction_to(get_global_mouse_position())
	mouse_dir = mouse_dir.normalized()
	animation_tree.set("parameters/blend_position", mouse_dir)
	rotate_to_mouse()


func  _physics_process(delta):
	# call movement
	move(delta)
	
	# run movement
	move_and_slide()


func hp_zero():
	queue_free()

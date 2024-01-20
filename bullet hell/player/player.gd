extends CharacterBody2D


var SPEED = 170.0

var MAX_TELEPORT_TIME = 3.0
var TELEPORT_HOLD_TIME
var teleport_pos = Vector2.ZERO
var duration = 0.0

var MAX_BOOST_TIME = 3.0
var BOOST_TIME = 0.0

var TELEPORT_DURATION = 0.0 
var MOUSE_LOCK_POS : Vector2 = Vector2.ZERO

var mousePos = Vector2.ZERO
var dir = 0.0
var dis = 0.0
var dis_single = 0.0
var apply = false


@onready var line : Line2D = $Line2D
var max_points = 10


func _physics_process(delta):

	_movement(delta)

	_teleportation(delta)

	move_and_slide()


func _process(delta):
	mousePos = get_global_mouse_position()
	dir = (mousePos - position).normalized()
	dis = global_position.distance_to(get_global_mouse_position())
	
	_trails()


func _movement(delta):
	
	if dis > 5:
		if !Input.is_action_pressed("boost") && !Input.is_action_pressed("teleport"):
			velocity = dir * SPEED
			
			BOOST_TIME -= delta / 2
			BOOST_TIME = clamp(BOOST_TIME, 0.0, MAX_BOOST_TIME)
		
		if Input.is_action_pressed("boost") && !Input.is_action_pressed("teleport") && BOOST_TIME <= MAX_BOOST_TIME:
			velocity = dir * SPEED * 2
			BOOST_TIME += delta
		
		if Input.is_action_pressed("boost") && BOOST_TIME >= MAX_BOOST_TIME:
			velocity = dir * SPEED
	else:
		velocity = Vector2.ZERO

func _teleportation(delta):
	if Input.is_action_pressed("teleport"):
		velocity = Vector2.ZERO
		if !apply:
			dis_single = dis
			teleport_pos = mousePos
			duration = dis_single / 400
			duration = clamp(duration, -0.1, 1)
			apply = true
		else:
			if duration <= 0:
				global_position = teleport_pos
			else:
				duration -= delta
			print(duration)
		
		
	elif Input.is_action_just_released("teleport"):
		apply = false
		return

func _trails():
	var pos = Vector2.ZERO
	for i in range(max_points):
		line.add_point(pos)
		pos = position - (-velocity)
		line.remove_point(max_points)
		print(pos)

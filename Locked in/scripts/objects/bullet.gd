extends CharacterBody2D


var bullet_speed : float
var life_time : float
var target_dir : float
var shot_position : Vector2
var damage : int


func setup(speed : float, _range : float, move_dir : float, shot_from : Vector2):
	bullet_speed = speed
	life_time = _range
	target_dir = move_dir
	shot_position = shot_from
	rotation += target_dir

func _ready():
	%"Life time".start(life_time)
	%"Life time".timeout.connect(timeout)

func _physics_process(delta):
	var direction = transform.x
	velocity = direction * 800
	move_and_slide()

func timeout():
	self.queue_free()

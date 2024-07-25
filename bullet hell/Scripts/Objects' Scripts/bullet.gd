extends CharacterBody2D

# main bullet speed
var bullet_speed : float
# bullet life time
var life_time : float
# shoot angle (should be applied in setup)
var target_dir : float


#bullet life timer
@onready var life_timer = %"Life time"


func setup(speed : float, range : float, move_dir : float):
	bullet_speed = speed
	life_time = range
	target_dir = move_dir


func _ready():
	life_timer.start(life_time)
	rotation += target_dir


func _physics_process(delta):
	var direction = transform.x
	velocity = direction * 800
	
	move_and_slide()


func life_timeout():
	self.queue_free()

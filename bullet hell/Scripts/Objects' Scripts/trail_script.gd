extends Line2D

@export var follow_mouse : bool = false
@export var target : Node2D

@export var thickness : float = 2
@export var color : Color

var queue = []
@export var max_point : int = 10

func _ready():
	default_color = color
	width = thickness

func _process(delta):
	queue.push_front(follow_target())
	
	if queue.size() > max_point:
		queue.pop_back()
	
	clear_points()
	
	for i in queue:
		add_point(i)

func follow_target():
	if follow_mouse:
		return get_global_mouse_position()
	else:
		return target.global_position

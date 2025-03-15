extends CharacterBody2D


var speed: float = 15000

var player: Player

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D as NavigationAgent2D


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	var dir = self.global_position.direction_to(
			navigation_agent.get_next_path_position()
	) .normalized()
	velocity = dir * speed * _delta
	
	move_and_slide()


func _make_new_path():
	navigation_agent.target_position = player.global_position
	


func _on_timer_timeout() -> void:
	_make_new_path()

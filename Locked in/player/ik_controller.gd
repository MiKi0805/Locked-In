extends Node2D


@export var follow_r_target: bool = false
@export var hand_r_target_pos: Vector2

@export var follow_l_target: bool = false
@export var hand_l_target_pos: Vector2

var hand_r_default_pos: Vector2
var hand_l_default_pos: Vector2
@onready var hand_r_ik_target: Marker2D = $"../IKTargets/HandRTarget"
@onready var hand_l_ik_target: Marker2D = $"../IKTargets/HandLTarget"


func _ready() -> void:
	hand_r_default_pos = hand_r_ik_target.position
	hand_l_default_pos = hand_l_ik_target.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if follow_r_target:
		hand_r_ik_target.global_position = hand_r_target_pos
	else:
		hand_r_ik_target.position = hand_r_default_pos
	
	if follow_l_target:
		hand_l_ik_target.global_position = hand_l_target_pos
	else:
		hand_l_ik_target.position = hand_l_default_pos

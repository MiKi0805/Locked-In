class_name Bullet
extends Area2D


@export var damage: int = 10

## Move bullet px/sec.
@export var speed: float = 50

@export var off_screen_lifetime: float = 2.0

var direction: Vector2

@onready var timer: Timer = $Timer
@onready var attack: Attack = $Attack


func _ready() -> void:
	rotation = direction.angle()
	attack.damage = damage


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta


func _on_bullet_in_screen() -> void:
	timer.stop()
	timer.wait_time = off_screen_lifetime


func _on_bullet_out_of_screen() -> void:
	timer.start()


func _on_timer_timeout() -> void:
	self.queue_free()

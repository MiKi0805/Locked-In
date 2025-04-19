class_name Bullet
extends Area2D


@export var damage: int = 10

## Move bullet px/sec.
@export var speed: float = 50

var direction: Vector2


func _ready() -> void:
	rotation = direction.angle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

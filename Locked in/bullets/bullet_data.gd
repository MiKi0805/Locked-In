class_name BulletData
extends Resource


## Damage that will be dealt when bullet is damaging a hitbox.
## Will use bullet default damage, if variable set to -1.
@export var damage: int = -1
## The speed that the bullet will travel with.
## Will use bullet default speed, if variable set to -1.
@export var speed: float = -1
## Bullet scene that will be use for what bullet to spawn.
@export var bullet_scene: PackedScene

# Bullet Transform
var direction: Vector2
var starting_position: Vector2

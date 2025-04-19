@icon("uid://4whm5ebkqn2j")
class_name Hitbox
extends Area2D


## Added a hitbox to the parent. Will detect a hit dealth by an 'Attack' component.

@export var health: Health


func _on_body_entered(body):
	var attack_component = body.get_node_or_null("Attack Component")
	if health && attack_component:
		health.hit_count += 1
		health.damage(attack_component.damage)
		body.queue_free()

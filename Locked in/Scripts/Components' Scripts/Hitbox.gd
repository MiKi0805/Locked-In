extends Area2D
class_name Hitbox_component

@export var health : Health_component

func _on_body_entered(body):
	var attack_component = body.get_node_or_null("Attack Component")
	if health && attack_component:
		health.hit_count += 1
		health.damage(attack_component.damage)
		body.queue_free()

@icon("uid://4whm5ebkqn2j")
class_name Hitbox
extends Area2D


## Added a hitbox to the parent. Will detect a hit dealth by an 'Attack' component.

@export var health: Health


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_body_entered)


func _on_body_entered(body):
	if Global.debug_mode:
		print(self, " | Body: " , body)
	
	var attack_component = body.get_node_or_null("Attack")
	if health && attack_component:
		health.hit_count += 1
		health.deal_damage(attack_component.damage)
		body.queue_free()

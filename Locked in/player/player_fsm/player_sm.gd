class_name PlayerSM
extends StateMachine


func _on_weapon_shot() -> void:
	on_child_transition(current_state, "knockback")

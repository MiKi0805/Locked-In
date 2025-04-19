extends Node


# Global function to spawn a bullet
func spawn_bullet(bullet_data: BulletData):
	var bullet : Bullet = bullet_data.bullet_scene.instantiate()
	
	bullet.damage = bullet_data.damage
	bullet.position = bullet_data.starting_position
	bullet.direction = bullet_data.direction
	bullet.speed = bullet_data.speed
	
	get_parent().add_child(bullet)  # Add bullet to the current scene

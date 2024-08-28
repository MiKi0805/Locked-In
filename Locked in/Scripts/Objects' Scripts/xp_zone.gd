extends Node2D


var player : Player


func _ready():
	$CPUParticles2D.process_material.radial_accel_max = -100
	get_tree().create_timer(25).timeout.connect(destroy)
	$AnimationPlayer.play("the_spin")
	$AnimationPlayer.speed_scale = 0.5
	var tween1 = create_tween()
	tween1.set_parallel(true)
	tween1.tween_property($Line2D, "scale", Vector2(2.5, 2.5), 15)
	tween1.tween_property($Line2D, "width", 3, 15)
	await tween1.step_finished
	tween1 = create_tween()
	tween1.set_parallel(true)
	tween1.tween_property($Line2D2, "default_color", Color.from_hsv(0, 0, 0, 0), 10)
	tween1.tween_property($Line2D/ColorRect2, "color", Color.from_hsv(0, 0, 0, 0), 10)


func _process(delta):
	if player:
		$CPUParticles2D.global_position = player.global_position
		Global.xp += 1 * delta


func destroy():
	player = null
	$CPUParticles2D.emitting = true
	$Line2D.queue_free()
	$Line2D2.queue_free()
	$AnimationPlayer.queue_free()
	$PointLight2D.queue_free()
	$CPUParticles2D.process_material.radial_accel_min = 100.0
	await get_tree().create_timer(1.5).timeout
	$CPUParticles2D.emitting = false
	await get_tree().create_timer(0.5).timeout
	queue_free()


func _on_area_2d_body_entered(body):
	$AnimationPlayer.speed_scale = 1
	$CPUParticles2D.emitting = true
	player = body


func _on_area_2d_body_exited(body):
	$AnimationPlayer.speed_scale = 0.5
	$CPUParticles2D.emitting = false
	$CPUParticles2D.position = Vector2.ZERO
	player = null

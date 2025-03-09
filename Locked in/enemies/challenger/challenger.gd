extends CharacterBody2D

# search player node (apply in _ready())
var player : Player

#Movement
# main speed
var speed : float = 200.0
# lerp weight (smoothing)
var SMOOTHING : float = 5
# approach the player in specific range(value)
var default_approach_range : float = 10
var approach_range : float = 10

# bool to make the enemy move after spawn(with delay)
var start : bool = false
# timer after spawn for the idle before moving
@onready var wait_timer = %spawn

# enemy to combine
var focused_enemy : Node2D
# bool to see if the enemy is on the ready state to be combine
var focus_to : bool
# combining token
var chance : int = 2

# local hp
@onready var health_counter : Health_component = $"Health Component"
var hp : int

# scaling base on hp
var hp_before : int
var hp_after : int
var leap : Vector2 = Vector2(0.1, 0.1)
var target_scale : Vector2 = Vector2(0.7, 0.7)

# die sfx
var die_sfx : PackedScene = load("res://Scenes/Objects/SFXs/enemy_die_sfx.tscn")


func _ready():
	$Texture.self_modulate.a = 0
	player = get_tree().get_first_node_in_group("player")
	$"spawn sfx".pitch_scale += randf_range(-0.2, 0.2)
	wait_timer.start(1.5)
	var tween_alpha = create_tween()
	tween_alpha.tween_property($Texture, 'self_modulate:a', 1, 2)
	$CPUParticles2D.emitting = true


func _process(_delta):
	cancle_focus()
	get_current_hp()
	change_scale()


func _physics_process(delta):
	move(delta)
	
	move_and_slide()


func move(delta):
	if start:
		var tween_rotation = create_tween()
		if !focus_to:
			if player != null:
				var target_rotation = global_position.direction_to(player.global_position).angle()
				tween_rotation.tween_property(self, 'rotation', target_rotation, 0.1)
				if global_position.distance_to(player.global_position) > approach_range:
					var dir = global_position.direction_to(player.global_position).normalized()
					velocity = lerp(velocity, dir * speed, SMOOTHING * delta)
				else:
					velocity = lerp(velocity, Vector2.ZERO, SMOOTHING * delta)
			elif player == null:
				velocity = lerp(velocity, Vector2.ZERO, SMOOTHING * delta)
		elif focus_to:
			var target_rotation = rotation + 5 * delta
			tween_rotation.tween_property(self, 'rotation', target_rotation, 0.1)
			if global_position.distance_to(focused_enemy.global_position) > approach_range:
				var dir = global_position.direction_to(focused_enemy.global_position).normalized()
				velocity = lerp(velocity, dir * speed, SMOOTHING * delta)
			else:
				velocity = lerp(velocity, Vector2.ZERO, SMOOTHING * delta)


func get_current_hp():
	hp = health_counter.health
	hp_after = hp


func change_scale():
	if hp_before != hp_after:
		var tween_scale = create_tween()
		if hp_after < hp_before: # hp decrease
			target_scale -= leap
			tween_scale.tween_property(self, 'scale', target_scale, 0.2)
		elif hp_after > hp_before: #hp increase
			var hp_increase : int = hp_after - hp_before
			for i in hp_increase:
				target_scale += leap
			tween_scale.tween_property(self, 'scale', target_scale, 0.5)
		hp_before = hp_after


func focused(requester : Node2D):
	focused_enemy = requester
	if focused_enemy:
		focus_to = true

func cancle_focus():
	if !focused_enemy:
		focus_to = false 
		$"merge timer".stop()


func wait_timeout():
	start = true
	wait_timer.queue_free()
	$CollisionPolygon2D.disabled = false

func merge_ready():
	health_counter.reset_hp(hp + focused_enemy.hp)
	chance -= 1
	focus_to = false
	focused_enemy.queue_free()
	approach_range = default_approach_range
	pass


func _hp_zero(hit_count):
	get_parent().get_parent().add_child(die_sfx.instantiate())
	Global.xp += hit_count
	queue_free()


func ready_to_combine(body):
	if body.is_in_group("enemy") && body != self:
		if (!focused_enemy && !focus_to && chance > 0) && (!body.focused_enemy && !body.focus_to && body.chance > 0):
			focused_enemy = body
			focus_to = true
			$"merge timer".start(3)
			body.focused(self)
			body.speed += 50
			approach_range = 0.5

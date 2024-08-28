extends Node2D

var pause : bool
var audio_bus : int

var added : bool

func _ready():
	audio_bus = AudioServer.get_bus_index('SFX')

func _process(_delta):
	if Input.is_action_just_pressed("esc"):
		if pause:
			Engine.time_scale = 1
			pause = !pause
		elif !pause:
			Engine.time_scale = 0
			pause = !pause
	if Input.is_action_pressed("slow"):
		Engine.time_scale = 0.4
		if !added:
			add_underwater_effects()
	elif !Input.is_action_pressed('slow') && !pause:
		Engine.time_scale = 1
		if added:
			remove_underwater_effect()

func add_underwater_effects():
	var bus_index = AudioServer.get_bus_index("SFX")

	# Add Low Pass Filter
	var low_pass_filter = AudioEffectLowPassFilter.new()
	low_pass_filter.cutoff_hz = 400
	AudioServer.add_bus_effect(bus_index, low_pass_filter)

	# Add Reverb
	var reverb = AudioEffectReverb.new()
	reverb.room_size = 0.3
	reverb.damping = 0.7
	reverb.spread = 0.2
	reverb.dry = -3
	reverb.wet = 0
	AudioServer.add_bus_effect(bus_index, reverb)

	added = true

func remove_underwater_effect():
	var effect = AudioServer.get_bus_effect_count(audio_bus)
	if effect != null:
		for i in effect:
			AudioServer.remove_bus_effect(audio_bus, i)
		if effect <= 0:
			added = false

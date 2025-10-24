extends AudioStreamPlayer2D

var sample_hz = 22050.0 # Keep the number of samples to mix low, GDScript is not super fast.
var pulse_hz = 150.0
var phase = 0.0

var last_rotation: float
const ROTATION_THRESHOLD: float = 0.1

var playback: AudioStreamPlayback = null # Actual playback stream, assigned in _ready().

func _fill_buffer():
	var increment = pulse_hz / sample_hz
	
	var to_fill = playback.get_frames_available()
	while to_fill > 0:
		# Sawtooth wave: ramps from -1.0 to 1.0 as phase goes from 0 to 1
		var sample = (2.0 * phase) - 1.0
		playback.push_frame(Vector2.ONE * sample) # Stereo
		phase = fmod(phase + increment, 1.0)
		to_fill -= 1


func _process(_delta):
	_fill_buffer()
	
	var rotation_change = abs(get_parent().rotation - last_rotation)
	
	print(volume_db)
	
	if rotation_change > ROTATION_THRESHOLD:
		volume_db = lerp(volume_db, 0.0, 10 * _delta)
		last_rotation = get_parent().rotation
	else:
		volume_db = lerp(volume_db, -80.0, 10 * _delta)


func _ready():
	# Setting mix rate is only possible before play().
	stream.mix_rate = sample_hz
	play()
	playback = get_stream_playback()
	# `_fill_buffer` must be called *after* setting `playback`,
	# as `fill_buffer` uses the `playback` member variable.
	_fill_buffer()


func _on_frequency_h_slider_value_changed(value):
	%FrequencyLabel.text = "%d Hz" % value
	pulse_hz = value


func _on_volume_h_slider_value_changed(value):
	# Use `linear_to_db()` to get a volume slider that matches perceptual human hearing.
	%VolumeLabel.text = "%.2f dB" % linear_to_db(value)
	$Player.volume_db = linear_to_db(value)

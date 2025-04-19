extends Node


func play_sfx(stream: AudioStream, position: Vector2):
	var sfx = OnePlayAudioStream.new()
	sfx.stream = stream
	sfx.global_position = position
	add_child(sfx)

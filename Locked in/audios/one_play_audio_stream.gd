class_name OnePlayAudioStream
extends AudioStreamPlayer2D


func _ready():
	play()


func _process(_delta: float) -> void:
	await finished
	queue_free()

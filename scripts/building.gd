extends Node3D


var rng = RandomNumberGenerator.new()


func _ready():
	var audio_stream = 'pop' + str(rng.randi_range(1, 4)) + '.wav'

	%AudioStreamPlayer.stream = load("res://assets/sounds/fx/pop/" + audio_stream)
	%AudioStreamPlayer.play()

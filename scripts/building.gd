extends Node3D


var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	var audio_stream = 'pop' + str(rng.randi_range(1, 4)) + '.wav'
	print(audio_stream)
	%AudioStreamPlayer.stream = load("res://assets/sounds/fx/pop/" + audio_stream)
	%AudioStreamPlayer.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

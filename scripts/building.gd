extends Node3D

var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var model: String


func _ready():
	var mod = %models.get_children()
	var model_found: bool = false
	
	for node in mod:
		if node.name == model:
			model_found = true
			node.show()
	
	if model_found == false:
		%default_cube.show()
	
	var audio_stream = 'pop' + str(rng.randi_range(1, 4)) + '.wav'

	%AudioStreamPlayer.stream = load("res://assets/sounds/fx/pop/" + audio_stream)
	%AudioStreamPlayer.play()

extends Node3D

var mesh_name
var rng = RandomNumberGenerator.new()


func _ready():
	var audio_stream = 'pop' + str(rng.randi_range(1, 4)) + '.wav'

	%AudioStreamPlayer.stream = load("res://assets/sounds/fx/pop/" + audio_stream)
	%AudioStreamPlayer.play()
	
	#marche po
	var material: StandardMaterial3D = $MeshInstance3D.get_surface_override_material(0)
	material.albedo_color = Color(randi_range(0, 255), randi_range(0, 255), randi_range(0, 255), 1)
	print(material.albedo_color)
	$MeshInstance3D.set_surface_override_material(0, material)

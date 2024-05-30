extends Node3D


var random_number: int = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	$baboon/Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_baboon()


func move_baboon():

	var updated = false
	
	if $baboon/Timer.time_left < 1 and updated == false:
		$baboon/Timer.stop()
		random_number = randi()% 4
		updated = true
	
	if (random_number == 0):
		$baboon.position.x += 2
		$baboon.rotation_degrees.y = -90
	elif (random_number == 1):
		$baboon.position.x -= 2
		$baboon.rotation_degrees.y = 90
	elif (random_number == 2):
		$baboon.position.z += 2
		$baboon.rotation_degrees.y = 180
	elif (random_number == 3):
		$baboon.position.z -= 2
		$baboon.rotation_degrees.y = 0

	if (updated == true):
		$baboon/Timer.start()

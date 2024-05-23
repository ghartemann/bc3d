extends Camera3D

signal click
var speed: int = 10


func _ready():
	click.connect(Callable(get_node("/root/Main"), "_on_click"))

func _input(event):
	if event.is_action_pressed("CamL"):
		rotation_degrees.y -= 90

	if event.is_action_pressed("CamR"):
		rotation_degrees.y += 90

func _physics_process(delta):
	var move = speed * delta

	if Input.is_action_pressed("Up"):
		position.z -= move
		position.x -= move
	
	if Input.is_action_pressed("Down"):
		position.z += move
		position.x += move
	
	if Input.is_action_pressed("Left"):
		position.x -= move
		position.z += move
	
	if Input.is_action_pressed("Right"):
		position.x += move
		position.z -= move

	if Input.is_action_pressed("ZoomIn") and size > 10:
		print(size)
		size -= speed / 10
	
	if Input.is_action_pressed("ZoomOut") and size < 100:
		size += speed / 10

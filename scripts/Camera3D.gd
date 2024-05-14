extends Camera3D

signal click
var speed: int = 10


func _ready():
	click.connect(Callable(get_node("/root/Main"), "_on_click"))

func _input(event):
	if event.is_action_pressed("click"):
		click.emit()

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

	if Input.is_action_pressed("ZoomIn"):
		size += speed
	
	if Input.is_action_pressed("ZoomOut"):
		size -= speed
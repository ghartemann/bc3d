extends Node3D


var speed: int = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	print('con')
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _input(event):
	# if event.is_action_pressed("Up"):
	# 	$Camera3D.position.z -= 0.2
	# 	$Camera3D.position.x -= 0.2

	#if event.is_action_pressed("Down"):
		#$Camera3D.position.z += 0.2
		#$Camera3D.position.x += 0.2
#
	#if event.is_action_pressed("Left"):
		#$Camera3D.position.x -= 0.2
		#$Camera3D.position.z += 0.2
#
	#if event.is_action_pressed("Right"):
		#$Camera3D.position.x += 0.2
		#$Camera3D.position.z -= 0.2

	if event.is_action_pressed("ZoomIn"):
		if $Camera3D.projection == Camera3D.PROJECTION_ORTHOGONAL:
			$Camera3D.size += speed
		else:
			$Camera3D.fov += speed
	
	if event.is_action_pressed("ZoomOut"):
		if $Camera3D.projection == Camera3D.PROJECTION_ORTHOGONAL:
			$Camera3D.size -= speed
		else:
			$Camera3D.fov -= speed

	if event.is_action_pressed("CameraMode"):
		if $Camera3D.projection == Camera3D.PROJECTION_ORTHOGONAL:
			$Camera3D.projection = Camera3D.PROJECTION_PERSPECTIVE
		else:
			$Camera3D.projection = Camera3D.PROJECTION_ORTHOGONAL

func _physics_process(delta):
	var move = speed * delta

	if Input.is_action_pressed("Up"):
		$Camera3D.position.z -= move
		$Camera3D.position.x -= move
	
	if Input.is_action_pressed("Down"):
		$Camera3D.position.z += move
		$Camera3D.position.x += move
	
	if Input.is_action_pressed("Left"):
		$Camera3D.position.x -= move
		$Camera3D.position.z += move
	
	if Input.is_action_pressed("Right"):
		$Camera3D.position.x += move
		$Camera3D.position.z -= move

func _on_input_event(camera, event, position, normal, shape_idx):
	
	var x = round(position.x) + 0.5
	var y = round(position.z) + 0.5
	#marker.transform.origin = Vector3(x, 0.01, y)


func _on_static_body_3d_input_event(camera, event, position, normal, shape_idx):
	print('connard')

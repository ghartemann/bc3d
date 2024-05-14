extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _input(event):
	if event.is_action_pressed("Up"):
		$Camera3D.position.z -= 0.2
		$Camera3D.position.x -= 0.2

	if event.is_action_pressed("Down"):
		$Camera3D.position.z += 0.2
		$Camera3D.position.x += 0.2

	if event.is_action_pressed("Left"):
		$Camera3D.position.x -= 0.2
		$Camera3D.position.z += 0.2

	if event.is_action_pressed("Right"):
		$Camera3D.position.x += 0.2
		$Camera3D.position.z -= 0.2

	if event.is_action_pressed("ZoomIn"):
		if $Camera3D.projection == Camera3D.PROJECTION_ORTHOGONAL:
			$Camera3D.size += 1
		else:
			$Camera3D.fov += 1
	
	if event.is_action_pressed("ZoomOut"):
		if $Camera3D.projection == Camera3D.PROJECTION_ORTHOGONAL:
			$Camera3D.size -= 1
		else:
			$Camera3D.fov -= 1

	if event.is_action_pressed("CameraMode"):
		if $Camera3D.projection == Camera3D.PROJECTION_ORTHOGONAL:
			$Camera3D.projection = Camera3D.PROJECTION_PERSPECTIVE
		else:
			$Camera3D.projection = Camera3D.PROJECTION_ORTHOGONAL

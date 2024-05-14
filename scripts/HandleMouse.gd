extends StaticBody3D

var marker


func _ready():
	marker = %Marker



func _input(event):
	print('saloperie')
	if event is InputEventMouseButton:
		pass
		#print("Mouse Click/Unclick at: ", event.position)
	elif event is InputEventMouseMotion:
		print(event.position)
		marker.transform.origin = Vector3(event.position.x, event.position.y, 0)
		#print("Mouse Motion at: ", event.position)

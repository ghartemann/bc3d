extends Node3D


var plane: Plane
var map: DataMap

var building = "res://scenes/components/building.tscn"

@onready var camera = %Camera3D

@export var selector: Node3D # The 'cursor'


func _ready():
	map = DataMap.new()
	plane = Plane(Vector3.UP, Vector3.ZERO)
	$AudioStreamPlayer.play()

func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	var world_position = plane.intersects_ray(
		camera.project_ray_origin(mouse_pos),
		camera.project_ray_normal(mouse_pos)
	)
	
	var x_adjusted = round(world_position.x / 100)
	var z_adjusted = round(world_position.z / 100)
	
	var gridmap_position = Vector3(x_adjusted, 0.001, z_adjusted)
	selector.position = lerp(selector.position, gridmap_position, delta * 40)


func _on_main_clicko():
	var building_res = load(building)
	var build = building_res.instantiate()
	
	build.position = Vector3(selector.position.x, 0.25, selector.position.z)
	get_node("/root/Main/World/GridMap").add_child(build)

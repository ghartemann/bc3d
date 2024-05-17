extends Node3D


var plane: Plane
var map: DataMap

var building: String = "res://scenes/components/building.tscn"
const ScatterUtil := preload("res://addons/proton_scatter/src/common/scatter_util.gd")

@onready var camera = %Camera3D

@export var selector: Node3D # The 'cursor'


func _ready():
	map = DataMap.new()
	plane = Plane(Vector3.UP, Vector3.ZERO)
	$AudioStreamPlayer.play()


func _process(delta):
	move_selector(delta)
	rotate_banana(delta)


func _unhandled_input(event: InputEvent):
	if (event is InputEventMouseButton && event.pressed == true && event.button_index == MOUSE_BUTTON_LEFT):
		#%UI.increment_via_bpc()
		#%LabelBananas.text = str(%UI.bananas)
	
		create_building(selector.position, building)


func get_mouse_pos() -> Vector2:
	return get_viewport().get_mouse_position()


func get_world_pos():
	var mouse_pos = get_mouse_pos()
	
	return plane.intersects_ray(
		camera.project_ray_origin(mouse_pos),
		camera.project_ray_normal(mouse_pos)
	)


func move_selector(delta):
	var world_position = get_world_pos()
	
	if !world_position:
		return
	
	var x_adjusted = round(world_position.x / 100)
	var z_adjusted = round(world_position.z / 100)
	
	var gridmap_position = Vector3(x_adjusted, 0.001, z_adjusted)
	selector.position = lerp(selector.position, gridmap_position, delta * 40)


func create_building(pos: Vector3, type: String):
	var building_res = load(type)
	var build = building_res.instantiate()
	
	var sel = selector.position
	
	build.position = Vector3(round(sel.x), 0.25, round(sel.z))

	get_node("/root/Main/World/GridMap").add_child(build)
	
	#marche po ça
	var node = $ProtonScatter/Exclusion.duplicate()
	node.position = Vector3(selector.position.x, 0, selector.position.z)
	$ProtonScatter.add_child(node)
	#update_gizmos()
	ScatterUtil.request_parent_to_rebuild(node)


func rotate_banana(delta):
	var r = %Banana3D.rotation
	%Banana3D.rotation = Vector3(r.x, r.y + (1 * delta), r.z)

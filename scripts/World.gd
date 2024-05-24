extends Node3D


signal buy(clicker)

var plane: Plane
var map: DataMap

var build_mode: bool
var selected_clicker # je peux pas typer cette merde
var built_clickers_pos: Array

var building: String = "res://scenes/components/building.tscn"
const ScatterUtil := preload("res://addons/proton_scatter/src/common/scatter_util.gd")
const pos_util := preload("res://scripts/utils/position.gd")

@onready var camera = %Camera3D

@export var selector: Node3D # The 'cursor'



########## BASE FUNCTIONS
func _ready():
	buy.connect(Callable(get_node("/root/Main"), "_on_buy"))
	
	map = DataMap.new()
	plane = Plane(Vector3.UP, Vector3.ZERO)
	$AudioStreamPlayer.play()
	
	toggle_build_mode(false)


func _process(delta):
	move_selector(delta)
	rotate_banana(delta)


func _unhandled_input(event: InputEvent):
	if (event is InputEventMouseButton && event.pressed == true):
		if (event.button_index == MOUSE_BUTTON_LEFT):
			#%UI.increment_via_bpc()
			#%LabelBananas.text = str(%UI.bananas)
		
			if (build_mode == true):
				create_building(selector.position, building)
		
		if (event.button_index == MOUSE_BUTTON_RIGHT):
			toggle_build_mode(false)



########## FUNCTIONS
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
		print('No world position')
		return

	var gridmap_position = Vector3(round(world_position.x), 0.01, round(world_position.z))
	selector.position = gridmap_position


func create_building(pos: Vector3, type: String):
	if (selected_clicker == null):
		return

	var sel = selector.position
	var requested_pos = Vector3(round(sel.x), 0, round(sel.z))

	if (is_building_pos_occupied(requested_pos) == true):
		print("Position ", requested_pos, " already occupied")
	else:
		print("Building ", selected_clicker.slug, " at ", requested_pos)
		
		var occupied_spaces = [
			Vector3(requested_pos.x - 1, 0, requested_pos.z - 1),
			Vector3(requested_pos.x + 1, 0, requested_pos.z + 1)
		]
		
		built_clickers_pos.push_back({
			'clicker': selected_clicker.slug,
			'pos': occupied_spaces
		})

		var building_res = load(type)
		var build = building_res.instantiate()
		build.position = requested_pos
		get_node("/root/Main/World/GridMap").add_child(build)
		
		buy.emit(selected_clicker)
	
		#marche po ça
		var node = $ProtonScatter/Exclusion.duplicate()
		node.position = Vector3(selector.position.x, 0, selector.position.z)
		$ProtonScatter.add_child(node)
		#update_gizmos()
		ScatterUtil.request_parent_to_rebuild(node)


func rotate_banana(delta):
	%Banana3D.transform.basis = %Banana3D.transform.basis.rotated(Vector3.UP, 0.03)


# je peux pas mettre plusieurs types parce que c'est pas supporté saloperie
func toggle_build_mode(enabled: bool, clicker = null):
	build_mode = enabled
	selector.visible = enabled
	selected_clicker = clicker if enabled else null

func is_building_pos_occupied(req_pos: Vector3) -> bool:
	for clicker in built_clickers_pos:
		if (pos_util.is_pos_occupied(req_pos, clicker['pos']) == true):
			return true
	
	return false

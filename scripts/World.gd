extends Node3D


signal buy(clicker)

var plane: Plane
var map: DataMap

var build_mode: bool
var selected_clicker # je peux pas typer cette merde
var built_clickers_pos: Array

var building: String = "res://scenes/components/building.tscn"
const ScatterUtil := preload("res://addons/proton_scatter/src/common/scatter_util.gd")

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
	
	var x_adjusted = round(world_position.x + .5)
	var z_adjusted = round(world_position.z + .5)
	
	var gridmap_position = Vector3(x_adjusted, 1, z_adjusted)
	selector.position = gridmap_position


func create_building(pos: Vector3, type: String):
	var building_res = load(type)
	var build = building_res.instantiate()
	
	var sel = selector.position
	
	build.position = Vector3(round(sel.x), 0, round(sel.z))

	get_node("/root/Main/World/GridMap").add_child(build)
	
	if (selected_clicker != null):
		if (is_pos_occupied(build.position)):
			print("Position already occupied")
			return
			
		buy.emit(selected_clicker)
		
		var bp = build.position
		var nine_pos = [
			Vector3(bp.x - 1, 0, bp.z - 1),
			Vector3(bp.x - 1, 0, bp.z),
			Vector3(bp.x - 1, 0, bp.z + 1),
			Vector3(bp.x, 0, bp.z - 1),
			build.position,
			Vector3(bp.x, 0, bp.z + 1),
			Vector3(bp.x + 1, 0, bp.z - 1),
			Vector3(bp.x + 1, 0, bp.z),
			Vector3(bp.x + 1, 0, bp.z + 1),
		];
		
		built_clickers_pos.push_back({
			'clicker': selected_clicker.slug,
			'pos': nine_pos
		})
	
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

func is_pos_occupied(sel_pos):	
	for built in built_clickers_pos:
		for pos in built['pos']:
			print(pos, sel_pos)
			if (pos == sel_pos):
				return true
	
	return false

extends Control

signal decoration(type, price)

var cursor_func: Script = preload("res://scripts/utils/cursor.gd")
var format: Script = preload("res://scripts/utils/format.gd")

var hovered: bool = false

var type: String:
	set(new_val):
		type = new_val
		%LabelValue.type = new_val
	get:
		return type

var price: float:
	set(new_val):
		price = new_val
		%LabelPrice.value = new_val
	get:
		return price

var decoration_name: String:
	set(new_val):
		decoration_name = new_val
		%LabelText.text = new_val
	get:
		return decoration_name

var decoration_slug: String

var size_map: int

var picture_path: String:
	set(new_val):
		picture_path = new_val
		%DecorationPicture.texture = ResourceLoader.load("res://assets/images/" + new_val)
	get:
		return picture_path

var description: String:
	set(new_val):
		description = new_val
		#%LabelTooltip.text = new_val
	get:
		return description


func _ready():
	add_to_group("decorations")
	add_to_group("Persist")
	
	set_button_text()
	decoration.connect(Callable(get_node("/root/Main"), "_on_decoration"))

func _process(_delta):
	if %Button.disabled == true:
		%DecorationPicture.modulate.a = 0.5
	else:
		%DecorationPicture.modulate.a = 1
	
	if hovered == true:
		cursor_func.change_cursor(true, %Button.disabled)
	else:
		cursor_func.change_cursor(false)

	set_button_text()
	
func _on_button_pressed():
	decoration.emit({
		'name': decoration_name,
		'slug': decoration_slug,
		'type': type,
		'price': price,
		'size_map': size_map
		})

func set_button_text():
	pass

func _on_mouse_entered():
	hovered = true

func _on_mouse_exited():
	hovered = false

# func save() -> Dictionary:
# 	var save_dict = {
# 		"filename": get_scene_file_path(),
# 		"parent": get_parent().get_path(),
# 		"nb_owned": nb_owned
# 	}
	
# 	return save_dict

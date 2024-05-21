extends Control

signal build(type, value, price)

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

var price_multiplier: float:
	set(new_val):
		price_multiplier = new_val
	get:
		return price_multiplier

var value: float:
	set(new_val):
		value = new_val
		%LabelValue.value = new_val
	get:
		return value

var nb_owned: int:
	set(new_val):
		nb_owned = new_val
		%LabelOwned.text = str(new_val)
		%LabelTooltip2.text = 'BPS total : ' + str(nb_owned * value)
	get:
		return nb_owned

var clicker_name: String:
	set(new_val):
		clicker_name = new_val
		%LabelText.text = new_val
	get:
		return clicker_name

var picture_path: String:
	set(new_val):
		picture_path = new_val
		%ClickerPicture.texture = ResourceLoader.load("res://assets/images/" + new_val)
	get:
		return picture_path

var description: String:
	set(new_val):
		description = new_val
		%LabelTooltip.text = new_val
	get:
		return description


func _ready():
	add_to_group("clickers")
	add_to_group("Persist")
	
	set_button_text()
	%Tooltip.hide()
	build.connect(Callable(get_node("/root/Main"), "_on_build"))

func _process(_delta):
	if %Button.disabled == true:
		%ClickerPicture.modulate.a = 0.5
	else:
		%ClickerPicture.modulate.a = 1
	
	if hovered == true:
		%Tooltip.show()
		cursor_func.change_cursor(true, %Button.disabled)
	else:
		%Tooltip.hide()
		cursor_func.change_cursor(false)
	
	if %Tooltip.visible == true:
		var mouse_pos = get_viewport().get_mouse_position()
		
		var x = mouse_pos.x + 100
		var y = mouse_pos.y
		%Tooltip.position = Vector2(x, y)
		
	set_button_text()
	
func _on_button_pressed():
	build.emit({'type': type, 'value': value, 'price': price})
	#buy_clicker()

func set_button_text():
	pass

func buy_clicker():
	price *= price_multiplier
	nb_owned += 1

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

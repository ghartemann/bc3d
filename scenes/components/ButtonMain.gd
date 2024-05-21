extends TextureButton

signal click

var cursor_func: Script = preload("res://scripts/utils/cursor.gd")
var nb_clicks: int = 0


func _ready():
	click.connect(Callable(get_node("/root/Main"), "_on_button_main_pressed"))

func _process(delta):
	$Label.text = str(nb_clicks)


func _pressed():
	nb_clicks += 1
	click.emit()


func _on_mouse_entered():
	cursor_func.change_cursor(true)

func _on_mouse_exited():
	cursor_func.change_cursor(false)

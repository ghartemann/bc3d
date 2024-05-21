extends TextureButton

signal click

func _ready():
	click.connect(Callable(get_node("/root/Main"), "_on_button_main_pressed"))

func _pressed():
	click.emit()

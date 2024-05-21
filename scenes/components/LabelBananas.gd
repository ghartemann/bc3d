extends Label

const format = preload("res://scripts/utils/format.gd")
var value: float = 0

func _process(_delta):
	text = 'Bananes : ' + format.format_for_display(value)

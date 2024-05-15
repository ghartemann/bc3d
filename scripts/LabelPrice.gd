extends Label

var format = preload("res://scripts/utils/format.gd")

var value: float
var type: String


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text = '🍌 ' + format.format_for_display(value)

const default_cursor = preload("res://assets/cursors/resized/left_ptr2.svg")
const pointer_cursor = preload("res://assets/cursors/resized/hand2.svg")
const no_cursor = preload("res://assets/cursors/resized/crossed_circle.svg")

static func change_cursor(hovering: bool, disabled: bool = false):
	var current_cursor = Input.get_current_cursor_shape()
	
	if hovering == true:
		if disabled == false:
			actually_change_cursor(pointer_cursor, current_cursor, Input.CURSOR_POINTING_HAND)
		else:
			actually_change_cursor(no_cursor, current_cursor, Input.CURSOR_FORBIDDEN)
	else:
		actually_change_cursor(default_cursor, current_cursor, Input.CURSOR_ARROW)

static func actually_change_cursor(type, current_cursor, expected_cursor):
	if current_cursor != expected_cursor:
		Input.set_custom_mouse_cursor(type, expected_cursor)

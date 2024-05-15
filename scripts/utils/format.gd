static func format_for_display(value: float) -> String:
	var toReturn: String
	var unit: String
	
	if value < 1000:
		value = snapped(value, 1)
	elif (value >= 1000 and value < 1000000):
		value = snapped(value / 1000, 0.01)
		unit = 'K'
	elif (value >= 1000000 and value < 1000000000):
		value = snapped(value / 1000000, 0.01)
		unit = 'M'
	elif (value >= 1000000000):
		value = snapped(value / 1000000000, 0.01)
		unit = 'B'
	elif (value >= 1000000000000):
		value = snapped(value / 1000000000000, 0.01)
		unit = 'T'
	elif (value >= 1000000000000000):
		value = snapped(value / 1000000000000000, 0.01)
		unit = 'Q'
	elif (value >= 1000000000000000000):
		value = snapped(value / 1000000000000000000, 0.01)
		unit = 'S'
	#après ça les int sont trop gros oups
	
	toReturn = str(value)
	
	if unit:
		toReturn += unit
	
	return toReturn

static func format_for_display_co2(value: float) -> String:
	var toReturn: String
	var unit: String
	
	if value < 1000:
		value = snapped(value, 1)
		unit = 'kg'
	elif (value >= 1000 and value < 1000000):
		value = snapped(value / 1000, 0.01)
		unit = 't'
	elif (value >= 1000000 and value < 1000000000):
		value = snapped(value / 1000000, 0.01)
		unit = 'Mt'
	elif (value >= 1000000000):
		value = snapped(value / 1000000000, 0.01)
		unit = 'Gt'
	
	toReturn = str(value) + ' ' + unit
	
	return toReturn

static func import_json(path: String) -> Array:
	var file = FileAccess.open(path, FileAccess.READ).get_as_text()
	
	return JSON.new().parse_string(file)

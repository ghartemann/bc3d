static func is_within_bounds(pos: Vector3, bounds: Array):
	return pos.x >= bounds[0].x and pos.x <= bounds[1].x and pos.z >= bounds[0].z and pos.z <= bounds[1].z

static func is_pos_occupied(req_pos: Vector3, bounds: Array) -> bool:
	if (
		is_within_bounds(req_pos, bounds)
		or is_within_bounds(Vector3(req_pos.x + 1, req_pos.y, req_pos.z), bounds)
		or is_within_bounds(Vector3(req_pos.x - 1, req_pos.y, req_pos.z), bounds)
		or is_within_bounds(Vector3(req_pos.x, req_pos.y, req_pos.z + 1), bounds)
		or is_within_bounds(Vector3(req_pos.x, req_pos.y, req_pos.z - 1), bounds)
		or is_within_bounds(Vector3(req_pos.x + 1, req_pos.y, req_pos.z + 1), bounds)
		or is_within_bounds(Vector3(req_pos.x - 1, req_pos.y, req_pos.z - 1), bounds)
		or is_within_bounds(Vector3(req_pos.x + 1, req_pos.y, req_pos.z - 1), bounds)
		or is_within_bounds(Vector3(req_pos.x - 1, req_pos.y, req_pos.z + 1), bounds)
	):
		return true
	
	return false

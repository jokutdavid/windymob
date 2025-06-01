extends Node2D

var TilesNode

@export var speed := 100

var path := []
var path_index = 0


func _ready():
	TilesNode = get_parent().get_node("../TilesNode")
	path = TilesNode.hastar.get_point_path(Vector2(0, 0), Vector2(10, 0))

	
func _process(delta):
	if !path.is_empty():
		var target = path[path_index] + Vector2(60, 60)
		var direction = target - position
		
		direction = direction.normalized()
		
		if (target - position).length() > 5:
			position += direction * delta * speed
		else:
			if not path_index == path.size() - 1:
				path_index += 1

func _input(event):
	if event is InputEventMouseButton:
		var current_id = find_nearest_walkable_cell(TilesNode.hastar, position)
		var target_id = find_nearest_walkable_cell(TilesNode.hastar, get_global_mouse_position())
		
		var id_path = TilesNode.hastar.get_id_path(current_id, target_id)
		path = []
		path_index = 0
		for i in id_path:
			path.append(TilesNode.hastar.get_point_position(i))
		path.pop_front()


func world_to_map(grid: AStarGrid2D, world_pos: Vector2) -> Vector2i:
	var cell_size = grid.cell_size
	var offset = grid.region.position
	return Vector2i(floor(world_pos.x / cell_size.x), floor(world_pos.y / cell_size.y)) - offset

func find_nearest_walkable_cell(grid: AStarGrid2D, world_pos: Vector2) -> Vector2i:
	var cell = world_to_map(grid, world_pos)
	if not grid.is_point_solid(cell):
		return cell

	var queue = [cell]
	var visited = {}
	while queue.size() > 0:
		var current = queue.pop_front()
		if current in visited:
			continue
		visited[current] = true

		if not grid.is_point_solid(current):
			return current

		for offset in [
			Vector2i(1, 0), Vector2i(-1, 0),
			Vector2i(0, 1), Vector2i(0, -1)
		]:
			var neighbor = current + offset
			if not visited.has(neighbor):
				queue.append(neighbor)

	return cell

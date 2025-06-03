extends Node3D

func _process(delta):
	var TilesNode = get_parent().get_node("../TilesNode")
	var grid_pos = TilesNode.world_to_map(Vector2(position.x, position.z)) / TilesNode.get_parent().get_parent().tile_width
	
	position.y = TilesNode.tile_grid[grid_pos.y][grid_pos.x].position.y

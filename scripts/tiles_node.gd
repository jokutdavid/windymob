extends Node2D

var TileChild = preload("res://scenes/tile.tscn")
var tile_grid : Array = []

var astar = AStar2D.new()

func get_point_id(x: int, y: int, grid_height: int) -> int:
	return x + y * grid_height

func _ready():
#	A* setup
	var Main = get_parent().get_parent()
	
	for x in range(Main.row_cols.x):
		tile_grid.append([])
		for y in range(Main.row_cols.y):
			var tile_child = TileChild.instantiate()
			add_child(tile_child)
			
			if y > 7 or (x == 6 and y < 5):
				tile_child.current_type = tile_child.tile_type.shallow_water
			else:
				tile_child.current_type = tile_child.tile_type.dirt
			
			tile_child.position = Vector2(x, y) * Main.tile_width
			tile_grid[x].append(tile_child)

			var point_id = get_point_id(x, y, Main.row_cols.y)
			astar.add_point(point_id, Vector2(x, y) * Main.tile_width)
			

	
	
	for x in range(Main.row_cols.x):
		for y in range(Main.row_cols.y):
			var current_id = get_point_id(x, y, Main.row_cols.y)
			
			var left_id = get_point_id(x - 1, y, Main.row_cols.y)
			if x > 0 and tile_grid[x - 1][y].current_type == tile_grid[0][0].tile_type.dirt:
				astar.connect_points(current_id, left_id)
				
			if x < Main.row_cols.x - 1 and tile_grid[x + 1][y].current_type == tile_grid[0][0].tile_type.dirt:
				var right_id = get_point_id(x + 1, y, Main.row_cols.y)
				astar.connect_points(current_id, right_id)
				
			if y > 0 and tile_grid[x][y - 1].current_type == tile_grid[0][0].tile_type.dirt:
				var up_id = get_point_id(x, y - 1, Main.row_cols.y)
				astar.connect_points(current_id, up_id)
				
			if y < Main.row_cols.y - 1 and tile_grid[x][y + 1].current_type == tile_grid[0][0].tile_type.dirt:
				var right_id = get_point_id(x, y + 1, Main.row_cols.y)
				astar.connect_points(current_id, right_id)

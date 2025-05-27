extends Node2D

var Tile = preload("res://scenes/tile.tscn")
var tile_grid : Array = []

var hastar = AStarGrid2D.new() # hastar -> human astar (pathfinding A* for humans)
var Main

func _ready():
	Main = get_parent().get_parent()
#	A* setup
	hastar.size = Main.row_cols
	hastar.cell_size = Vector2(Main.tile_width, Main.tile_width)
	hastar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	hastar.update()
	
	
	for y in Main.row_cols.y:
		tile_grid.append([])
		for x in Main.row_cols.x:
			var tile_child = Tile.instantiate()
			tile_child.position = Vector2(x, y) * Main.tile_width
			add_child(tile_child)
			
			tile_child.id = Vector2(x, y)
		
			tile_child.level = 1
			if y > 8 or (x == 8 and y < 4):
				tile_child.type = tile_child.ttp.water
				hastar.set_point_solid(Vector2(x, y), true)
			else:
				tile_child.type = tile_child.ttp.dirt
				hastar.set_point_solid(Vector2(x, y), false)
			
			tile_grid[y].append(tile_child)
	
	hastar.update()

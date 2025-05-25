extends Node2D

var astar = AStar2D.new()

func _ready():
	for x in get_parent().row_cols.x:
		for y in get_parent().row_cols.y:
			astar.add_point(x + y * get_parent().row_cols.y, Vector2(x, y) * get_parent().tile_width)
	
	astar.connect_points(0, 1)

extends Node2D

var TileChild = preload("res://scenes/tile.tscn")
var tile_grid : Array = []


func _ready():
	var Main = get_parent().get_parent()
	
	
	for x in range(Main.row_cols.x):
		tile_grid.append([])
		for y in range(Main.row_cols.y):
			var tile_child = TileChild.instantiate()
			add_child(tile_child)
			tile_child.position = Vector2(x, y) * get_parent().get_parent().tile_width
			
			if y > 5:
				tile_child.current_type = get_child(0).tile_type.shallow_water
			else:
				tile_child.current_type = get_child(0).tile_type.dirt
			
			tile_grid[x].append(tile_child)
			
	

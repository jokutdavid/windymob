extends Node2D

var TerrainChild = preload("res://scenes/terrain_tile.tscn")
var terrain_grid : Array = []


func _ready():
	var Main = get_parent().get_parent()
	
	
	for x in range(Main.row_cols.x):
		terrain_grid.append([])
		for y in range(Main.row_cols.y):
			var terrain_child = TerrainChild.instantiate()
			add_child(terrain_child)
			terrain_child.position = Vector2(x, y) * get_parent().get_parent().tile_width
			terrain_grid[x].append(terrain_child)

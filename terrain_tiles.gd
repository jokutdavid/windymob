extends Node2D

var TerrainChild = preload("res://terrain_tile.tscn")
var terrain_grid : Array = []


func _ready():
	for x in range(10):
		terrain_grid.append([])
		for y in range(10):
			var terrain_child = TerrainChild.instantiate()
			add_child(terrain_child)
			terrain_child.position = Vector2(x, y) * 120
			terrain_grid[x].append(terrain_child)

extends Node3D

#height shit for noise map or smt
@export_range(0, 8, 0.2) var deep_ocean := 1.0
@export_range(0, 8, 0.2) var close_ocean := 2.0
@export_range(0, 8, 0.2) var shallow_ocean := 3.0

@export_range(0, 8, 0.2) var sand := 4.0
@export_range(0, 8, 0.2) var dirt := 5.0

@export_range(0, 8, 0.2) var hill := 6.0
@export_range(0, 8, 0.2) var mountain := 7.0
@export_range(0, 8, 0.2) var mountain_peak := 8.0

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
	
	var noise = FastNoiseLite.new()
	noise.seed = randi()
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.frequency = 0.05
	
	
	for y in Main.row_cols.y:
		tile_grid.append([])
		for x in Main.row_cols.x:
			var tile_child = Tile.instantiate()
			tile_child.position = Vector3(x, 0, y) * Main.tile_width
			add_child(tile_child)
			
			tile_child.id = Vector2(x, y)
			
			
		
			var level: int
			
			var value = noise.get_noise_2d(x, y) + 1
			if value <= deep_ocean / 4:
				level = -3
			elif value <= close_ocean / 4:
				level = -2
			elif value <= shallow_ocean / 4:
				level = -1
			elif value <= sand / 4:
				level = 0
			elif value <= dirt / 4:
				level = 1
			elif value <= hill / 4:
				level = 2
			elif value <= mountain / 4:
				level = 3
			elif value <= mountain_peak / 4:
				level = 4
			else:
				level = 99
			
			tile_child.id = Vector2(x, y)
			tile_child.level = level
			
			tile_child.type = tile_child.ttp.terrain
			tile_child.update_sprite()
			
			hastar.set_point_solid(Vector2(x, y), !range(0, 3).has(tile_child.level))
			
			tile_grid[y].append(tile_child)
	
	hastar.update()
	
	
	
	surround_water_with_sand()


func surround_water_with_sand():
	var grid_height = Main.row_cols.y
	var grid_width = Main.row_cols.x
	
	
	for y in grid_height:
		for x in grid_width:
			if tile_grid[y][x].level < 0:
				if y > 0:
					if tile_grid[y - 1][x].level > 0:
						tile_grid[y - 1][x].level = 0
				
				if y < grid_height - 1:
					if tile_grid[y + 1][x].level > 0:
						tile_grid[y + 1][x].level = 0
				
				if x > 0:
					if tile_grid[y][x - 1].level > 0:
						tile_grid[y][x - 1].level = 0
				
				if x < grid_width - 1:
					if tile_grid[y][x + 1].level > 0:
						tile_grid[y][x + 1].level = 0
			

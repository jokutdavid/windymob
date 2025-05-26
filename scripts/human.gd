extends Node2D

@export var speed : int = 300
var target_pos : Vector2

var current_path : PackedVector2Array = []
var path_index := 0

var Game

func update_path():
	var TilesNode = Game.get_node("./TilesNode")
	
	var start_pos = TilesNode.astar.get_closest_point(position)
	var end_pos = TilesNode.astar.get_closest_point(Vector2(840, 360))
	
	if current_path.is_empty():
		current_path = TilesNode.astar.get_point_path(start_pos, end_pos)
	
	print(current_path)
	
	if !current_path.is_empty():
		target_pos = current_path[path_index]
	target_pos += Vector2(60, 60)

func _ready():
	Game = get_parent().get_parent()
	
func _process(delta):
	update_path()
	
	var to_target = target_pos - position
	var distance = to_target.length()
	
	if distance > 5:
		var direction = to_target.normalized()
		position += direction * speed * delta
	else:
		path_index += 1
		if path_index >= current_path.size():
			current_path = []
			path_index = 0
	

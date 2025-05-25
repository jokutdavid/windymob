extends Node2D

@export var speed : int
var target_pos : Vector2

var current_path : PackedVector2Array = []
var path_index := 0

var Game

func update_path():
	current_path = Game.astar.get_point_path(0, 1)
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
	

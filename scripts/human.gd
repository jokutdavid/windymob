extends Node2D

var TilesNode

@export var speed := 100

var path := []
var path_index = 0


func _ready():
	TilesNode = get_parent().get_node("../TilesNode")
	path = TilesNode.hastar.get_point_path(Vector2(0, 0), Vector2(10, 0))

	
func _process(delta):
	if !path.is_empty():
		var target = path[path_index] + Vector2(60, 60)
		var direction = target - position
		
		direction = direction.normalized()
		
		if (target - position).length() > 5:
			position += direction * delta * speed
		else:
			if not path_index == path.size() - 1:
				path_index += 1

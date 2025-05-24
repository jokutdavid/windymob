extends Node2D

var moving = false
var goal = Vector2(3, 0)

var move_dist = get_parent().get_parent().get_parent().tile_width / 2

var time_acc = 1.0

func _process(delta):
	time_acc += delta
	
	if time_acc > 5:
		time_acc = 0
		position = goal * move_dist
		goal = position / move_dist
		
	
	

extends Node2D

@export var tile_width = 120
@export var row_cols = Vector2i.ZERO

func _process(delta):
	if delta > 1.0 / 55:
		print("Warning! " + str(int(1 / delta)) + "fps")

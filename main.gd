extends Node2D

@export var row_cols = Vector2i.ZERO

func _process(delta):
	if delta > 1.0 / 50:
		print(str(delta) + ":" + str(1.0 / 50))
		print("Sub 50 fps")

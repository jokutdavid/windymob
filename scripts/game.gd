extends Node3D

@export var speed := 60.0

var time_minutes := 0.0



func _process(delta):
	time_minutes += floor(speed * delta)

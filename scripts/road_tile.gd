extends Node2D

var isTurned: bool

func _ready() :
	isTurned = abs(self.rotation_degrees - 90) < 0.01
	print(str(isTurned) + "\n")

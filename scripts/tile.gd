extends Node2D

@export var type = ttp.dirt
var level = 1

var id : Vector2

var old_type = ttp.none

enum ttp {
	none,
	dirt,
	water,
}

func return_enum_name(type: ttp) -> String:
	var result
	match type:
		ttp.dirt: 
			result = "dirt"
		ttp.water:
			result = "water"
		_:
			result = "na"
	return result

func randomize_texture_rotations():
	match randi_range(0, 3):
		0:
			$Area2D/TextureRect.rotation_degrees = 0
		1:
			$Area2D/TextureRect.rotation_degrees = 90
		2:
			$Area2D/TextureRect.rotation_degrees = 180
		3:
			$Area2D/TextureRect.rotation_degrees = 270

func update_sprite():
	var texture_rect = $Area2D/TextureRect
	var name = return_enum_name(type)
	var path = "res://art/tiles/" + name + "_" + str(level) + ".png"
	var texture = load(path)
	
	texture_rect.texture = texture

func _ready():
	randomize_texture_rotations()

func _process(delta):
	if type != old_type:
		old_type = type
		update_sprite()
	

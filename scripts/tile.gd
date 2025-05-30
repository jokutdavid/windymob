extends Node2D

@export var type = ttp.none
@export var level = 1

var id : Vector2

var old_type = ttp.none

enum ttp {
	terrain,
	none,
	
}


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
	var path: String
	match type:
		ttp.terrain:
			path = "res://art/tiles/terrain/terrain_" + str(level) + ".png"
		_:
			path = "res://art/tiles/missing_texture.png"
	var IMAGE = FileAccess.open(path, FileAccess.READ)
	var texture
	if IMAGE:
		texture = load(path)
	else:
		texture = load("res://art/tiles/missing_texture.png")
	
	
	texture_rect.texture = texture

func _ready():
	randomize_texture_rotations()
	pass
	draw

var counter := 0
func _process(delta):
	counter += delta
	if type != old_type or counter > 10:
		counter = 0
		old_type = type
		update_sprite()

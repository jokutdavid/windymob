extends Node2D

@export var current_type = tile_type.dirt

enum tile_type {
	dirt,
	shallow_water,
}

func randomize_text_rotations():
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
	var texture : Texture
	match current_type:
		tile_type.dirt:
			texture = preload("res://art/terrain/dirt_01.png")
		tile_type.shallow_water:
			texture = preload("res://art/terrain/shallow_water_01.png")
	texture_rect.texture = texture

func _ready():
	randomize_text_rotations()

func _process(delta):
	update_sprite()
	

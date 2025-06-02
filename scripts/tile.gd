extends Node3D

@export var type = ttp.none
@export var level: int

var id : Vector2
var old_type = ttp.none
var old_level = -999

enum ttp {
	terrain,
	none,
	
}


func randomize_texture_rotations():
	match randi_range(0, 3):
		0:
			$MeshInstance3D.rotation_degrees.z = 0
		1:
			$MeshInstance3D.rotation_degrees.z = 90
		2:
			$MeshInstance3D.rotation_degrees.z = 180
		3:
			$MeshInstance3D.rotation_degrees.z = 270

func update_sprite():	
	var material = StandardMaterial3D.new()
	
	# If no override material exists yet, create one	
	var path: String
	match type:
		ttp.terrain:
			path = "res://art/tiles/terrain/terrain_" + str(level) + ".png"
		_:
			path = "res://art/tiles/missing_texture.png"
	
	var file = FileAccess.open(path, FileAccess.READ)
	var texture: Texture2D
	
	if file:
		texture = load(path)
	else:
		texture = load("res://art/tiles/missing_texture.png")
	
	material.albedo_texture = texture
	$MeshInstance3D.set_surface_override_material(0, material)

func _ready():
	randomize_texture_rotations()
	pass
	
func _process(delta):
	if level != old_level or type != old_type:
		old_level = level
		old_type = type
		update_sprite()
		
		position.y = pow(level, 3) * 4 - level * 4

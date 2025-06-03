extends OmniLight3D

var Main

func _ready():
	Main = get_parent().get_parent()
	position = Vector3(Main.row_cols.x * Main.tile_width / 2, 800, Main.row_cols.y * Main.tile_width / 2)

func _process(delta):
	light_energy = abs(sin(get_parent().time_minutes / 460) * 1200) + 1200

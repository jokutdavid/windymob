extends OmniLight3D

func _process(delta):
	position.x = get_node("../Camera3D").position.x
	position.z = get_node("../Camera3D").position.z

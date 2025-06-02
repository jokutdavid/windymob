extends Camera3D

var Main
var map_size
var tile_size
@export var clamp_margin := 1.0

var scroll_speed = 1000  # pixels per second

var drag_pos = Vector2.ZERO
var dragging: bool

@export var ZOOM_MIN = 350
@export var ZOOM_MAX = 3300
@export_range(0, 1) var MODE = -1

var target = Vector3(-90, 0, 0)

var y_pressed = false

func _ready():
	Main = get_parent()
	map_size = Main.row_cols  # In tiles
	tile_size = Main.tile_width            # Size of a tile in world units  

func _process(delta):
	var new_pos = Vector2(position.x, position.z)
	
	var input_vector = Vector2.ZERO # lets a vector and gives it direction based on input from the user
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1

	input_vector = input_vector.normalized() # noramlises the values, and applies them to position
	new_pos += input_vector * scroll_speed * delta / 1000 * position.y

	

	if MODE == 1:
		target = Vector3(1, 1, 0) * -35
		new_pos = Vector2(position.x, position.z)
	if MODE == -1:
		target = Vector3(1, 0, 0) * -90
	
	if (target - rotation_degrees).length() > 1:
		rotation_degrees += (target - rotation_degrees).normalized()
	
	if Input.is_key_label_pressed(KEY_Y):
		if !y_pressed:
			MODE = MODE * -1
		y_pressed = true
	else:
		y_pressed = false
	
	
	position.x = new_pos.x
	position.z = new_pos.y
	
	#at the end of frame makes sure that the viewport doesn't exit the usable frame	
	clamp_camera_position()
	
func _input(event):
	var changed_y = position.y
	if event is InputEventMouseButton: #changes zoom based on scroll
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			changed_y = changed_y * 1.1
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			changed_y = changed_y * 0.9
	
		position.y = clamp(changed_y, ZOOM_MIN, ZOOM_MAX)
		
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragging = true
				drag_pos = event.position
			else:
				dragging = false
	elif event is InputEventMouseMotion and dragging:
		var from = get_viewport().get_camera_3d().project_position(drag_pos, position.y)
		var to = get_viewport().get_camera_3d().project_position(event.position, position.y)

		var delta_world = from - to
		if MODE == -1:
			position.x += delta_world.x
			position.z += delta_world.z

		drag_pos = event.position
		
		
func clamp_camera_position():
	var cam = self
	
	var board_width = Main.tile_width * Main.row_cols.x
	var board_height = Main.tile_width * Main.row_cols.y
		
	position.x = clamp(position.x, 0, board_width)
	position.z = clamp(position.z, 0, board_height)

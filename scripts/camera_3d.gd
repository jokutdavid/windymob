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

	
	
	#at the end of frame makes sure that the viewport doesn't exit the usable frame using a buffer
	position.x = new_pos.x
	position.z = new_pos.y
	
	clamp_camera_position()
	print(position)
	#position.z = max(get_viewport().size.y / 2 - buffer, min(new_pos.y, Main.row_cols.y * 120 - get_viewport().size.y / 2 + buffer))
	
	
	
func _input(event):
	var changed_y = position.y
	if event is InputEventMouseButton: #changes zoom based on scroll
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			changed_y = changed_y * 1.1
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			changed_y = changed_y * 0.9
	
	position.y = clamp(changed_y, ZOOM_MIN, ZOOM_MAX)
		

func clamp_camera_position():
	var cam = self
	
	var board_width = Main.tile_width * Main.row_cols.x
	var board_height = Main.tile_width * Main.row_cols.y
		
	position.x = clamp(position.x, 0, board_width)
	position.z = clamp(position.z, 0, board_height)
